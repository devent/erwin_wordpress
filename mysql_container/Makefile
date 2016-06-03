VERSION := 5.7
NAME := db
WORK := ../root/var/lib/mysql
CONFIG_FILE := my.conf
CONFIG := conf.d
ROOT_PASSWORD := auHoh5fei4biSooyobae1ahp8Xi1iaGo

define DOCKER_CMD :=
mkdir -p $(WORK); \
WORK_DIR=`realpath $(WORK)`; \
CONFIG_FILE_DIR=`realpath $(CONFIG_FILE)`; \
CONFIG_DIR=`realpath $(CONFIG)`; \
docker run \
--name $(NAME) \
--dns=172.17.0.1 \
-v "$$WORK_DIR:/var/lib/mysql" \
-v "$$CONFIG_FILE_DIR:/etc/mysql/my.cnf" \
-v "$$CONFIG_DIR:/etc/mysql/conf.d" \
-e MYSQL_ROOT_PASSWORD="$(ROOT_PASSWORD)" \
-d \
mysql:$(VERSION)
endef

include ../make_container/Makefile

.PHONY +: configFiles run rerun rm clean test restart user drop dropdb dropuser

run: _run

rerun: _rerun

rm: _rm

clean: _clean

test: _test
	
restart: _restart

user: test
	$(call check_defined, DB_USER DB_PASSWORD DB_HOST, Database user credentials and host)
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
	$(call check_defined, DB_USER DB_HOST, Database user and host)
	mysql=( mysql --protocol=socket -uroot -p"$(ROOT_PASSWORD)" ); \
	if [ -z "$(DB_NAME)" ]; then \
	docker exec $(NAME) bash -c "echo \"REVOKE ALL PRIVILEGES, GRANT OPTION FROM '$$DB_USER'@'$$DB_HOST' ;\" | $${mysql[*]}"; \
	else \
	docker exec $(NAME) bash -c "echo \"REVOKE ALL PRIVILEGES ON $$DB_NAME.* FROM '$$DB_USER'@'$$DB_HOST' ;\" | $${mysql[*]}"; \
	fi

dropuser: test
	$(call check_defined, DB_USER DB_HOST, Database user and host)
	mysql=( mysql --protocol=socket -uroot -p"$(ROOT_PASSWORD)" ); \
	docker exec $(NAME) bash -c "echo \"DROP USER '$$DB_USER'@'$$DB_HOST';\" | $${mysql[*]}"
	mysql=( mysql --protocol=socket -uroot -p"$(ROOT_PASSWORD)" ); \
	docker exec $(NAME) bash -c "echo 'FLUSH PRIVILEGES ;' | $${mysql[*]}"
