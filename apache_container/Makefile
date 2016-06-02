SHELL := /bin/bash
VERSION := 5.6-apache
NAME := apache
A2CONF := apache2.conf
CONF := ../root/etc/apache2/conf-enabled
CONF_DIR := $(shell realpath $(CONF))
MODS := ../root/etc/apache2/mods-enabled
MODS_DIR := $(shell realpath $(MODS))
SITES := ../root/etc/apache2/sites-enabled
SITES_DIR := $(shell realpath $(SITES))
WEAVE := /usr/local/bin/weave
.PHONY: rerun run rm clean test reload config

run: $(WEAVE) $(CONF) $(MODS) $(SITES)
	eval "$$(weave env)"; \
	docker run \
	--name $(NAME) \
	--dns=172.17.0.1 \
	-v "$(SITES_DIR):/etc/apache2/sites-enabled" \
	-p 80:80 \
	-d \
	php:$(VERSION)
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
	
config:
	$(copyConfig)
	$(apacheGraceful)

reload: $(WEAVE) test config

$(WEAVE):
	[ -x $(WEAVE) ]

$(CONF):
	mkdir -p "$(CONF)"
	$(eval CONF_DIR := $(shell realpath $(CONF)))
	
$(MODS):
	mkdir -p "$(MODS)"
	$(eval MODS_DIR := $(shell realpath $(MODS)))
	
$(SITES):
	mkdir -p "$(SITES)"
	$(eval SITES_DIR := $(shell realpath $(SITES)))
	

define copyConfig =
$(eval A2CONF_DIR := $(shell realpath $(A2CONF)))
eval "$$(weave env)"; \
docker cp "$(A2CONF_DIR)" "$(NAME):/etc/apache2/apache2.conf"
endef
	
define apacheGraceful =
eval "$$(weave env)"; \
docker exec $(NAME) apachectl -k graceful
endef
	
