SHELL := /bin/bash
VERSION := 1.11
NAME := nginx-backend
WORK := ../root/var/www/$(DOMAIN)
WORK_DIR := $(shell realpath $(WORK))
CONF := nginx.conf
CONF_DIR := $(shell realpath $(CONF))
SITES := ../root/etc/nginx/sites-enabled
WEAVE := /usr/local/bin/weave
.PHONY: rerun run rm clean test reload config

run: $(WEAVE) $(CONF) $(SITES)
	eval "$$(weave env)"; \
	CONF_DIR=`realpath $(CONF)`; \
	SITES_DIR=`realpath $(SITES)`; \
	docker run \
	--name $(NAME) \
	--dns=172.17.0.1 \
	-v "$$CONF_DIR:/etc/nginx/nginx.conf:ro" \
	-v "$$SITES_DIR:/etc/nginx/sites-enabled:ro" \
	-v "$(WORK_DIR):/usr/share/nginx/html" \
	-p 80:80 \
	-d \
	nginx:$(VERSION)
	$(copyConfig)
	$(apacheGraceful)

rerun: rm run

rm:
	if [ -n "`docker ps -a | grep $(NAME)`" ]; then \
	eval "$$(weave env)"; \
	docker rm -f $(NAME); \
	fi

clean:

test:
	[ -n "`docker ps -a | grep $(NAME)`" ]
	
reload: $(WEAVE) test
	$(nginxRestart)

$(WEAVE):
	[ -x $(WEAVE) ]
	
$(CONF):

$(SITES):
	mkdir -p "$(SITES)"
	

define nginxRestart =
eval "$$(weave env)"; \
docker restart $(NAME)
endef
	
