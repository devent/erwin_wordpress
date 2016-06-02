SHELL := /bin/bash
VERSION := 4.5-fpm
DOMAIN := muellerpublic.de
NAME := wp_$(subst .,_,$(DOMAIN))
WORK := ../root/var/www/$(DOMAIN)
WORK_DIR := $(shell realpath $(WORK))
DB_HOST := db.weave.local
DB_USER := $(NAME)
DB_PASSWORD := temaiceeCh9unephahFojiegheechie4
DB_NAME := $(NAME)
WEAVE := /usr/local/bin/weave
.PHONY: rerun run rm clean

run: $(WEAVE) $(WORK)
	eval "$$(weave env)"; \
	docker run \
	--name $(NAME) \
	--dns=172.17.0.1 \
	-e WORDPRESS_DB_HOST=$(DB_HOST) \
	-e WORDPRESS_DB_USER=$(DB_USER) \
	-e WORDPRESS_DB_PASSWORD=$(DB_PASSWORD) \
	-e WORDPRESS_DB_NAME=$(DB_NAME) \
	-e WORDPRESS_TABLE_PREFIX="wp_" \
	-v "$(WORK_DIR):/var/www/html" \
	-d \
	wordpress:$(VERSION)

rerun: rm run

rm:
	if [ -n "`docker ps -a | grep $(NAME)`" ]; then \
	eval "$$(weave env)"; \
	docker rm -f $(NAME); \
	fi

clean:
	rm -rf "$(WORK)"

$(WEAVE):
	[ -x $(WEAVE) ]

$(WORK):
	mkdir -p "$(WORK)"
	$(eval WORK_DIR := $(shell realpath $(WORK)))
	
