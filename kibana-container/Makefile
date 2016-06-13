VERSION := 4.5
NAME := kibana

define DOCKER_CMD :=
docker run \
--name $(NAME) \
--dns=172.17.0.1 \
-d \
-e ELASTICSEARCH_URL=http://el0.weave.local:9200 \
-p 5601:5601 \
kibana:$(VERSION)
endef

include ../make_utils/Makefile.help
include ../make_utils/Makefile.functions
include ../make_utils/Makefile.container

.PHONY +: run rerun rm clean test restart

run: _run ##@default Starts the container.

rerun: _rerun ##@target Stops and starts the container.

rm: _rm ##@target Stops and removes the container.

clean: _clean ##@target Stops and removes the container and removes all created files.

test: _test ##@target Tests if the container is running.
	
restart: _restart ##@target Restarts the container.
