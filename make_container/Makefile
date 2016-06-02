SHELL := /bin/bash
WEAVE := /usr/local/bin/weave
.PHONY: run rerun rm clean test restart

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

$(call check_defined, SHELL)
$(call check_defined, VERSION, image version)
$(call check_defined, NAME, image name)
$(call check_defined, DOCKER_CMD, docker run command)
      
run: $(WEAVE)
	eval "$$(weave env)"; \
	$(DOCKER_CMD)

rerun: rm run

rm:
	if [ -n "`docker ps -a | grep $(NAME)`" ]; then \
	eval "$$(weave env)"; \
	docker rm -f $(NAME); \
	fi

clean: rm

test:
	[ -n "`docker ps -a | grep $(NAME)`" ]
	
restart: $(WEAVE) test
	eval "$$(weave env)"; \
	docker restart $(NAME)

$(WEAVE):
	cd ../weave && $(MAKE)
