VERSION := 4.5-fpm
IMAGE_NAME := erwinnttdata/wp_muellerpublic_de_data:latest
DOMAIN := muellerpublic.de.test
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
wordpress:$(VERSION)
endef

include ../make_utils/Makefile.help
include ../make_utils/Makefile.functions
include ../make_utils/Makefile.container

.PHONY +: run rerun rm clean test restart bash dataContainer rm_dataContainer testDataContainer

run: dataContainer _run ##@default Starts the container.

rerun: _rerun ##@targets Stops and starts the container.

rm: _rm ##@targets Stops and removes the container.

clean: _clean rm_dataContainer ##@targets Stops and removes the container and removes all created files.

test: testDataContainer _test ##@targets Tests if the container is running.

restart: _restart ##@targets Restarts the container.

bash: test _bash ##@targets Executes the bash inside the running container.

dataContainer: _dataContainer ##@targets Creates the data container.

rm_dataContainer: _rm_dataContainer ##@targets Removes the data container.

testDataContainer: _testDataContainer ##@targets Tests that the data container is available.

build:
	$(MAKE) -f Makefile.image build
