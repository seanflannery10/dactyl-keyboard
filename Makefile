.ONESHELL:

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(dir $(mkfile_path))

DOCKER_CMD := "docker"
.DEFAULT_GOAL := help

help: ## Print this help message.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
.PHONY: help

build-4x5:
	(source $$(conda info --base)/etc/profile.d/conda.sh; conda activate dactyl-keyboard; python src/dactyl_manuform.py --config main --override 4x5)
.PHONY: build-4x5

build-4x6:
	(source $$(conda info --base)/etc/profile.d/conda.sh; conda activate dactyl-keyboard; python src/dactyl_manuform.py --config main --override 4x6)
.PHONY: build-4x6

build-5x6:
	(source $$(conda info --base)/etc/profile.d/conda.sh; conda activate dactyl-keyboard; python src/dactyl_manuform.py --config main --override 5x6)
.PHONY: build-5x6

build: build-4x5 build-4x6 build-5x6 ## Build keyboards using conda
	rm things/*/*.txt
.PHONY: build

check-requirements:
	@if ! command -v ${DOCKER_CMD} %> /dev/null; then \
		echo "Docker executable not found."
		exit 1
	fi
.PHONY: check-requirements

build-container: check-requirements
	${DOCKER_CMD} build -t dactyl-keyboard -f docker/Dockerfile .
.PHONY: build-container

build-models: check-requirements build-container ## Build keyboard using docker.
	${DOCKER_CMD} run --rm --platform linux/amd64 --name dactyl-keyboard -v ${current_dir}:/app dactyl-keyboard
.PHONY: build-models
