PRE_COMMIT_HOOKS=.git/hooks/pre-commit

.PHONY: all
all: setup lint test ## run all linting and tests

.PHONY: setup
setup: setup-requirements-dev ## setup development requirements

.PHONY: setup-requirements-dev
setup-requirements-dev:
	pip3 install -r requirements.dev.txt

.PHONY: clean
clean: clean-test-images

.PHONY: clean-test-images
clean-test-images:
	cd tests && find . -name "Dockerfile" -exec rm -f {} \;

.PHONY: test
test: update-test-images run-tests ## run all tests
	./tests/run-tests.sh

tests/%/Dockerfile:
	./tests/update_test_images.py --dockerfile=$@

.PHONY: test-xenial
test-xenial: tests/images/xenial/Dockerfile
	./tests/run-tests.sh xenial

.PHONY: test-bionic
test-bionic: tests/images/bionic/Dockerfile
	./tests/run-tests.sh bionic

.PHONY: test-focal
test-focal: tests/images/focal/Dockerfile
	./tests/run-tests.sh focal

.PHONY: test-stretch
test-stretch: tests/images/stretch/Dockerfile
	./tests/run-tests.sh stretch

.PHONY: test-buster
test-buster: tests/images/buster/Dockerfile
	./tests/run-tests.sh buster

.PHONY: update-test-images
update-test-images:
	./tests/update_test_images.py

.PHONY: run-tests
run-tests:
	./tests/run-tests.sh

.PHONY: lint
lint: $(PRE_COMMIT_HOOKS) ## lint all files
	pre-commit run -a

$(PRE_COMMIT_HOOKS):
	pre-commit install

.PHONY: help
help:  ## print this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
