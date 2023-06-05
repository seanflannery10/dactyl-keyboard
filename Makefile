.DEFAULT_GOAL := help

help: ## Print this help message.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
.PHONY: help

build-3x5:
	(source $$(conda info --base)/etc/profile.d/conda.sh; conda activate dactyl-keyboard; python src/dactyl_manuform.py --config main --override 3x5)
.PHONY: build-3x5

build-3x6:
	(source $$(conda info --base)/etc/profile.d/conda.sh; conda activate dactyl-keyboard; python src/dactyl_manuform.py --config main --override 3x6)
.PHONY: build-3x5

build-4x6:
	(source $$(conda info --base)/etc/profile.d/conda.sh; conda activate dactyl-keyboard; python src/dactyl_manuform.py --config main --override 4x6)
.PHONY: build-4x6

build: build-3x5 build-3x6 build-4x6
	exit 0
.PHONY: build