REPOSITORY := erwinnttdata
NAME := deadwood
BUILD ?=
VERSION ?= 3.2.09-build_$(BUILD)

build:
	$(call check_defined, BUILD, Build number)
build: _build ##@targets Builds the docker image.

deploy:
	$(call check_defined, BUILD, Build number)
deploy: _deploy ##@targets Deployes the docker image to the repository.

include ../../make_utils/Makefile.help
include ../../make_utils/Makefile.functions
include ../../make_utils/Makefile.image
