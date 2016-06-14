REPOSITORY := erwinnttdata
NAME := maradns-deadwood
BUILD ?= 024
VERSION ?= 2.0.13-d3.2.09-build_$(BUILD)

build:
	$(call check_defined, BUILD, Build number)
build: _build ##@targets Builds the docker image.
	cd maradns && $(MAKE) build BUILD=$(BUILD)
	cd deadwood && $(MAKE) build BUILD=$(BUILD)

deploy:
	$(call check_defined, BUILD, Build number)
deploy: _deploy ##@targets Deployes the docker image to the repository.
	cd maradns && $(MAKE) deploy BUILD=$(BUILD)
	cd deadwood && $(MAKE) deploy BUILD=$(BUILD)

include ../make_utils/Makefile.help
include ../make_utils/Makefile.functions
include ../make_utils/Makefile.image
