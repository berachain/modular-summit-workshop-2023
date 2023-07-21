########################################################
#                       Makefile                       #
########################################################

# Default target
all: build


########################################################
#                         Setup                        #
########################################################

# Generate versioning information
TAG_COMMIT := $(shell git rev-list --abbrev-commit --tags --max-count=1)
TAG := $(shell git describe --abbrev=0 --tags ${TAG_COMMIT} 2>/dev/null || true)
COMMIT := $(shell git rev-parse --short HEAD)
DATE := $(shell git log -1 --format=%cd --date=format:"%Y%m%d")
VERSION := $(TAG:v%=%)
ifneq ($(COMMIT), $(TAG_COMMIT))
    VERSION := $(VERSION)-next-$(COMMIT)-$(DATE)
endif
ifneq ($(shell git status --porcelain),)
    VERSION := $(VERSION)-dirty
endif


########################################################
#                       Building                       #
########################################################

# List of services names
DIR_NAMES := backend limit liquidation

# Build docker images for all services
build-docker-%:
	@echo Building bts-$* docker image
	@echo ${COMMIT}
	docker build -t bts-$*:$(COMMIT) -f services/Dockerfile --build-arg SERVICE_NAME=$* ./

# Target for building the application in all directories
build-docker: \
	$(patsubst %, build-docker-%, $(DIR_NAMES)) 
	@echo Building bts-contracts
	@forge build --silent

# Build all services
build-%:
	@echo Building bts-$*
	@go build -o bin/bts-$* services/$*/cmd/main.go

# Target for building the application in all directories
build: \
	$(patsubst %, build-%, $(DIR_NAMES)) 
	@echo Building bts-contracts
	@forge build --silent

# Format the contracts (TODO add go formatting)
format: |
	forge fmt

########################################################
#                        Testing                       #
########################################################