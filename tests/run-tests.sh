#!/usr/bin/env bash

TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT=$(dirname "$TESTS_DIR")

ROLE_NAME="$(basename "$PROJECT_ROOT")"
TEST_HOME=/home/test

IMAGES_DIR="images"

docker_run_opts=()

error() {
    echo "$@" 1>&2
}

# Detect Windows Subsystem for Linux
detect_wsl() {
    is_wsl=0
    if [[ -d "/run/WSL" ]]; then
        echo "*** Windows Subsystem for Linux (WSL2) detected"
        is_wsl=1
        wsl_version='WSL2'
        return
    fi
    if [ ! -e /proc/version ]; then
        return
    fi
    if grep -q Microsoft /proc/version; then
        echo "*** Windows Subsystem for Linux (WSL1) detected"
        is_wsl=1
        wsl_version='WSL1'
        return
    fi
}

setup_mount_root() {
    if [ "${is_wsl}" == "1" ] && [ "${wsl_version}" == "WSL1" ]; then
        MOUNT_ROOT="$(pwd -P | sed 's~/mnt/c/~c:/~')"
    else
        MOUNT_ROOT="$(pwd -P)"
    fi
}

setup_docker_opts() {
    if [ -z "$CI" ]; then
        docker_run_opts+=("-it")
    fi
}

# Stop all containers
finish() {
    local containers=""
    containers=$(docker ps -q --filter=name="${ROLE_NAME}")
    if [ -n "${containers}" ]; then
        echo "*** Stop all test containers"
        # shellcheck disable=SC2086
        docker stop ${containers}
    fi
}

# Stop container
stop() {
    local image=$1
    local container_name="${ROLE_NAME}-${image}-tests"
    echo "*** Stop container with ${image}"
    docker stop "${container_name}"
}

# Build image
build() {
    local image=$1
    local image_name="${ROLE_NAME}-${image}"
    local image_dir="${TESTS_DIR}/${IMAGES_DIR}/${image}"
    local dockerfile="${image_dir}/Dockerfile"
    local base_image
    base_image=$(grep "^FROM" "${dockerfile}" | sed 's/FROM //')
    echo "*** Pull base image ${base_image}"
    docker pull "${base_image}"
    echo "*** Build image ${image}"
    docker build -t "${image_name}" "${image_dir}"
}

# Start container in the background
start() {
    local image=$1
    local image_name="${ROLE_NAME}-${image}"
    local container_name="${ROLE_NAME}-${image}-tests"
    echo "*** Start container with image ${image}"
    docker run --rm -d \
        "${docker_run_opts[@]}" \
        -e "TEST_ENV=${image}" \
        -v "${MOUNT_ROOT}:${TEST_HOME}/${ROLE_NAME}" \
        --name "${container_name}" \
        "${image_name}" || {
        error "failed to start container"
        exit 1
    }
}

run_tests() {
    local image=$1
    run_tests_with_git "$image" || {
        error "failed Git installation in ${image}"
        return 1
    }
    run_tests_with_installer "$image" || {
        error "failed native installer in ${image}"
        return 1
    }
}

run_tests_with_git() {
    local image=$1
    local test_scripts=(
        "test_with_git.sh"
    )
    echo "*** Run tests installing with Ansible from Git"
    for test_script in "${test_scripts[@]}"; do
        start "${image}"
        run_test_script "${image}" "${test_script}"
        stop "${image}"
        # Give Docker time to clean up
        sleep 1
    done
}

run_tests_with_installer() {
    local image=$1
    local test_scripts=(
        "test_with_installer.sh"
    )
    echo "*** Run tests installing with the Linuxbrew installer"
    for test_script in "${test_scripts[@]}"; do
        start "${image}"
        run_test_script "${image}" "${test_script}"
        stop "${image}"
        # Give Docker time to clean up
        sleep 1
    done
}

run_test_script() {
    local image=$1
    local test_script=$2
    local container_name="${ROLE_NAME}-${image}-tests"
    echo "*** Run tests with ${test_script} in ${image}"
    docker exec \
        "${docker_run_opts[@]}" \
        --user test \
        "${container_name}" \
        bash -ilc "${TEST_HOME}/${ROLE_NAME}/tests/${test_script}"
}

if ! command -v docker /dev/null; then
    error "docker not found"
    exit 1
fi

trap finish EXIT

detect_wsl

setup_docker_opts

cd "${TESTS_DIR}"

images=("$@")
if [ ${#images[@]} -eq 0 ]; then
    images=(images/*/Dockerfile)
    images=("${images[@]/images\//}")
    images=("${images[@]/\/Dockerfile/}")
fi

cd "${PROJECT_ROOT}"

setup_mount_root

set -e

for i in "${images[@]}"; do
    build "$i"
done

for i in "${images[@]}"; do
    run_tests "$i"
done
