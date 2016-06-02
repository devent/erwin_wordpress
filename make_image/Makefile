SHELL := /bin/bash
.PHONY: build deploy

# Check that given variables are set and all have non-empty values,
# die with an error otherwise.
#
# Author: http://stackoverflow.com/questions/10858261/abort-makefile-if-variable-not-set
#
# Params:
#   1. Variable name(s) to test.
#   2. (optional) Error message to print.
check_defined = \
    $(foreach 1,$1,$(__check_defined))
__check_defined = \
    $(if $(value $1),, \
      $(error Undefined $1$(if $(value 2), ($(strip $2)))))

$(call check_defined, REPOSITORY, docker image repository)
$(call check_defined, NAME, docker image name)
$(call check_defined, VERSION, docker image name)

build:
	if [ -z "`docker images | egrep '$(REPOSITORY)/$(NAME)\s*$(VERSION)'`" ]; then \
	docker build \
	--build-arg https_proxy=$$HTTPS_PROXY --build-arg http_proxy=$$HTTP_PROXY \
	--build-arg HTTPS_PROXY=$$HTTPS_PROXY --build-arg HTTP_PROXY=$$HTTP_PROXY \
	--build-arg ftp_proxy=$$FTP_PROXY --build-arg FTP_PROXY=$$FTP_PROXY \
	--build-arg no_proxy=$$NO_PROXY --build-arg NO_PROXY=$$NO_PROXY \
	-t $(REPOSITORY)/$(NAME):$(VERSION) \
	-t $(REPOSITORY)/$(NAME):latest .; \
	fi
	
deploy: build
	$(call check_defined, DOCKER_USER, DOCKER_PASSWORD, docker repository login)
	docker login -u$(DOCKER_USER) -p$(DOCKER_PASSWORD); \
	docker push $(REPOSITORY)/$(NAME):$(VERSION); \
	docker push $(REPOSITORY)/$(NAME):latest
