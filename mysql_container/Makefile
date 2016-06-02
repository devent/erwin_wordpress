SHELL := /bin/bash
VERSION := 5.7
NAME := db
WORK := ../root/var/mysql
WORK_DIR := $(shell realpath $(WORK))
CONFIG := ../root/etc/mysql/conf.d
CONFIG_DIR := $(shell realpath $(CONFIG))
ROOT_PASSWORD := auHoh5fei4biSooyobae1ahp8Xi1iaGo
WEAVE := /usr/local/bin/weave
.PHONY: rerun run rm clean test user drop

run: $(WEAVE) $(WORK) $(CONFIG)
	cp conf.d/* $(CONFIG)/
	eval "$$(weave env)"; \
	docker run \
	--name $(NAME) \
	--dns=172.17.0.1 \
	-v "$(WORK_DIR):/var/lib/mysql" \
	-v "$(CONFIG_DIR):/etc/mysql/conf.d" \
	-e MYSQL_ROOT_PASSWORD="$(ROOT_PASSWORD)" \
	-d \
	mysql:$(VERSION)

rerun: rm run

rm:
	if [ -n "`docker ps -a | grep $(NAME)`" ]; then \
	eval "$$(weave env)"; \
	docker rm -f $(NAME); \
	fi

clean:
	rm -rf "$(WORK)"

test:
	[ -n "`docker ps -a | grep $(NAME)`" ]
	
reload: $(WEAVE) test
	cp conf.d/* $(CONFIG)/
	eval "$$(weave env)"; \
	docker restart $(NAME)

user: test
	[ -n "$$DB_USER" ]
	[ -n "$$DB_PASSWORD" ]
	[ -n "$$DB_HOST" ]
	mysql=( mysql --protocol=socket -uroot -p"$(ROOT_PASSWORD)" ); \
	docker exec $(NAME) bash -c "echo \"CREATE USER '$$DB_USER'@'$$DB_HOST' IDENTIFIED BY '$$DB_PASSWORD' ;\" | $${mysql[*]}"
	if [ -n "$$DB_NAME" ]; then \
	mysql=( mysql --protocol=socket -uroot -p"$(ROOT_PASSWORD)" ); \
	docker exec $(NAME) bash -c "echo \"GRANT ALL ON $$DB_NAME.* TO '$$DB_USER'@'$$DB_HOST' ;\" | $${mysql[*]}"; \
	fi
	mysql=( mysql --protocol=socket -uroot -p"$(ROOT_PASSWORD)" ); \
	docker exec $(NAME) bash -c "echo 'FLUSH PRIVILEGES ;' | $${mysql[*]}"

drop: dropdb dropuser
	
dropdb: test
	[ -n "$$DB_USER" ]
	[ -n "$$DB_HOST" ]
	mysql=( mysql --protocol=socket -uroot -p"$(ROOT_PASSWORD)" ); \
	if [ -z "$$DB_NAME" ]; then \
	docker exec $(NAME) bash -c "echo \"REVOKE ALL PRIVILEGES, GRANT OPTION FROM '$$DB_USER'@'$$DB_HOST' ;\" | $${mysql[*]}"; \
	else \
	docker exec $(NAME) bash -c "echo \"REVOKE ALL PRIVILEGES ON $$DB_NAME.* FROM '$$DB_USER'@'$$DB_HOST' ;\" | $${mysql[*]}"; \
	fi

dropuser: test
	[ -n "$$DB_USER" ]
	[ -n "$$DB_HOST" ]
	mysql=( mysql --protocol=socket -uroot -p"$(ROOT_PASSWORD)" ); \
	docker exec $(NAME) bash -c "echo \"DROP USER '$$DB_USER'@'$$DB_HOST';\" | $${mysql[*]}"
	mysql=( mysql --protocol=socket -uroot -p"$(ROOT_PASSWORD)" ); \
	docker exec $(NAME) bash -c "echo 'FLUSH PRIVILEGES ;' | $${mysql[*]}"
	
$(WEAVE):
	[ -x $(WEAVE) ]

$(WORK):
	mkdir -p "$(WORK)"
	$(eval WORK_DIR := $(shell realpath $(WORK)))
	
$(CONFIG):
	mkdir -p "$(CONFIG)"
	$(eval CONFIG_DIR := $(shell realpath $(CONFIG)))
	
