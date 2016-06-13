REPOSITORY := erwinnttdata
NAME := maradns-deadwood
VERSION ?= 2.0.13-d3.2.09-build_014

build: _build ##@target Builds the docker image.
	cd maradns && $(MAKE) build
	cd deadwood && $(MAKE) build

deploy: _deploy ##@target Deployes the docker image to the repository.
	cd maradns && $(MAKE) deploy
	cd deadwood && $(MAKE) deploy

include ../make_utils/Makefile.help
include ../make_utils/Makefile.functions
include ../make_utils/Makefile.image
