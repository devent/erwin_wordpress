VERSION := latest
IMAGE_NAME := erwinnttdata/wp_muellerpublic_data:latest
DOMAIN := wordpress.muellerpublic.nttdata.com
NAME := wp_muellerpublic
VOL_NAME := vol3
MOUNT_PATH := var/www/html
DATA_VOLUME_NAME := wp_muellerpublic_data
DB_HOST := db.weave.local
DB_USER := wp_muellerpublic
DB_PASSWORD := 1234
DB_NAME := wp_muellerpublic

define DOCKER_CMD :=
docker run \
--name $(NAME) \
--dns=172.17.0.3 \
--volumes-from $(DATA_VOLUME_NAME) \
-e WORDPRESS_DB_HOST=$(DB_HOST) \
-e WORDPRESS_DB_USER=$(DB_USER) \
-e WORDPRESS_DB_PASSWORD=$(DB_PASSWORD) \
-e WORDPRESS_DB_NAME=$(DB_NAME) \
-e WORDPRESS_TABLE_PREFIX="wp_" \
-d \
erwinnttdata/wordpress:$(VERSION)
endef

include ../make_utils/Makefile.help
include ../make_utils/Makefile.functions
include ../make_utils/Makefile.container

.PHONY +: run rerun stop rm clean test restart bash
.PHONY +: dataContainer rm_dataContainer testDataContainer
.PHONY +: backend backend-rerun backend-stop backend-rm backend-clean backend-test backend-restart backend-bash

run: image-build dataContainer _run backend ##@default Starts the container.

rerun: rm image-clean image-build run ##@targets Stops, removes and re-starts the container.

stop: backend-stop _stop ##@targets Stops the container.

rm: _rm backend-rm ##@targets Stops and removes the container.

clean: _clean backend-clean rm_dataContainer image-clean ##@targets Stops and removes the container and removes all created files.

test: testDataContainer backend-test _test ##@targets Tests if the container is running.

restart: _restart backend-restart ##@targets Restarts the container.

bash: test _bash ##@targets Executes the bash inside the running container.

dataContainer: _dataContainer ##@targets Creates the data container.

rm_dataContainer: _rm_dataContainer ##@targets Removes the data container.

testDataContainer: _testDataContainer ##@targets Tests that the data container is available.

backend:
	$(MAKE) -f Makefile.nginx

backend-rerun:
	$(MAKE) -f Makefile.nginx rerun

backend-stop:
	$(MAKE) -f Makefile.nginx stop

backend-rm:
	$(MAKE) -f Makefile.nginx rm

backend-clean:
	$(MAKE) -f Makefile.nginx clean

backend-test:
	$(MAKE) -f Makefile.nginx test

backend-restart:
	$(MAKE) -f Makefile.nginx restart

backend-bash:
	$(MAKE) -f Makefile.nginx bash

image-build:
	$(MAKE) -f Makefile.image build

image-clean:
	$(MAKE) -f Makefile.image clean

image-deploy:
	$(MAKE) -f Makefile.image deploy
