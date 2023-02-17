
.DEFAULT_GOAL := help

# Use VERBOSE=1 make <command> to get verbose output
ifndef VERBOSE
.SILENT:
endif

.PHONY: help
help:  ## print this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort -d | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo ""
	$(MAKE) list-images

PRE_COMMIT_HOOKS = .git/hooks/pre-commit

TEST_IMAGES = $(shell ls tests/*/Dockerfile | xargs dirname | xargs basename)

.PHONY: setup
setup: $(PRE_COMMIT_HOOKS)

.PHONY: test
test: ## run tests with all available Docker images
	./tests/run-tests

.PHONY: list-images
list-images: ## list available test images
	@echo "Available test images:"
	@for i in $(TEST_IMAGES); do echo "$$i" | awk '{printf "\033[36m%-30s\033[0m run tests with %s\n", $$1, $$1}'; done

.PHONY: $(TEST_IMAGES)
$(TEST_IMAGES):
	./tests/run-tests $@

.PHONY: lint
lint: $(PRE_COMMIT_HOOKS)
	pre-commit run -a

$(PRE_COMMIT_HOOKS):
	pre-commit install
