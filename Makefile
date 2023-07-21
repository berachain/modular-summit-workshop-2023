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
DIR_NAMES := celestia-da op-chain polaris-chain

# Build docker images for all services
build-docker-%:
	@echo Building $* docker image
	@echo ${COMMIT}
	docker build -t $*:$(COMMIT) -f $*/Dockerfile  --build-arg SERVICE_NAME=$* ./

# Target for building the application in all directories
build-docker: \
	$(patsubst %, build-docker-%, $(DIR_NAMES)) 