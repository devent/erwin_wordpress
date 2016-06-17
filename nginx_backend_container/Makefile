VERSION := 1.11
NAME := nginx-backend
CONF := nginx.conf
SITES := sites
DATA_VOLUME_NAME := wp_muellerpublic_data

define DOCKER_CMD :=
docker run \
--name $(NAME) \
--dns=172.17.0.3 \
--volumes-from $(DATA_VOLUME_NAME) \
-v "`realpath $(CONF)`:/etc/nginx/nginx.conf:ro" \
-v "`realpath $(SITES)`:/etc/nginx/sites-enabled:ro" \
-p 80:80 \
-d \
nginx:$(VERSION)
endef

include ../make_utils/Makefile.help
include ../make_utils/Makefile.functions
include ../make_utils/Makefile.container

.PHONY +: run rerun rm clean test restart bash

run: _run ##@default Starts the container.

rerun: _rerun ##@targets Stops and starts the container.

rm: _rm ##@targets Stops and removes the container.

clean: _clean ##@targets Stops and removes the container and removes all created files.

test: _test ##@targets Tests if the container is running.

restart: _restart ##@targets Restarts the container.

bash: test _bash ##@targets Executes the bash inside the running container.
