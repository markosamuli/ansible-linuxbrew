#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT=$(dirname "$DIR")

error() {
    echo "$@" 1>&2
}

set -e

# Variables to pass to ansible-playbook
ansible_vars=(
    "'linuxbrew_use_installer':false"
)
extra_vars=$(printf ",%s" "${ansible_vars[@]}")
extra_vars="{${extra_vars:1}}"

# Paths in which Ansible will search for Roles
ANSIBLE_ROLES_PATH=$(dirname "$PROJECT_ROOT")
export ANSIBLE_ROLES_PATH

cd "$PROJECT_ROOT"

echo "*** Check syntax"

ansible-playbook tests/test.yml -i tests/inventory --syntax-check

echo "*** Run Ansible playbook"

ansible-playbook tests/test.yml -i tests/inventory --connection=local \
    -e "${extra_vars}"

echo "*** Idempotence test"

idempotence="fail"
ansible-playbook tests/test.yml -i tests/inventory --connection=local \
    -e "${extra_vars}" |
    grep -q 'changed=0.*failed=0' && idempotence="pass"
if [ "${idempotence}" == "pass" ]; then
    echo 'Idempotence test: pass'
else
    echo 'Idempotence test: fail'
    exit 1
fi

echo "*** Verify installed Homebrew version"

bash -i -c 'command -v brew && brew --version' || {
    error "Homebrew installation failed in bash"
    exit 1
}

zsh -i -c 'command -v brew && brew --version' || {
    error "Homebrew installation failed in zsh"
    exit 1
}
