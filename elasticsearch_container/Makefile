VERSION := latest
NODE_NUMBER ?= 0
NAME := el$(NODE_NUMBER)
CLUSTER_NAME := muellerpublic
NODE_NAME := $(NAME)
DATA := ../root/usr/share/elasticsearch/data

define DOCKER_CMD :=
docker run \
--name $(NAME) \
--dns=172.17.0.1 \
-v "`realpath $(DATA)`:/usr/share/elasticsearch/data" \
-d \
elasticsearch:$(VERSION) \
elasticsearch \
-Des.cluster.name="$(CLUSTER_NAME)" \
-Des.node.name="$(NODE_NAME)"
endef

include ../make_utils/Makefile.help
include ../make_utils/Makefile.functions
include ../make_utils/Makefile.container

.PHONY +: run rerun rm clean test restart

run: $(DATA) _run ##@default Starts the container.

rerun: _rerun ##@target Stops and starts the container.

rm: _rm ##@target Stops and removes the container.

clean: _clean ##@target Stops and removes the container and removes all created files.
	rm -rf "$(DATA)"

test: _test ##@target Tests if the container is running.
	
restart: _restart ##@target Restarts the container.

$(DATA):
	mkdir -p "$(DATA)"
