VERSION := latest
NAME := db
CONFIG := conf
ROOT_PASSWORD := auHoh5fei4biSooyobae1ahp8Xi1iaGo
VOL_NAME := vol1
MOUNT_PATH := var/lib/mysql
IMAGE_NAME := erwinnttdata/mysql-name-resolve:$(VERSION)

define DOCKER_CMD :=
CONFIG_DIR=`realpath $(CONFIG)`; \
docker run \
--name $(NAME) \
--dns=172.17.0.1 \
--volumes-from $(subst /,_,$(MOUNT_PATH)) \
-v "$$CONFIG_DIR:/etc/mysql/conf.d" \
-e MYSQL_ROOT_PASSWORD="$(ROOT_PASSWORD)" \
-d \
$(IMAGE_NAME)
endef

include ../make_utils/Makefile.functions
include ../make_utils/Makefile.container

.PHONY +: run rerun rm clean test restart dataContainer rm_dataContainer user drop dropdb dropuser

run: dataContainer _run

rerun: _rerun

rm: _rm

clean: _clean rm_dataContainer

test: _test
	
restart: _restart

dataContainer: _dataContainer

rm_dataContainer: _rm_dataContainer

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
