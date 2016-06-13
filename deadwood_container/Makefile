VERSION := latest
NAME := deadwood
CACHE := ../root/var/cache/deadwood
# Set the option PORT_ON_LOCALHOST to '-p 127.0.0.1:53:53/udp' to use the DNS server on localhost.
PORT_ON_LOCALHOST ?=

define DOCKER_CMD :=
docker run \
--name $(NAME) \
--dns=172.17.0.1 \
-v "`realpath dwood3rc`:/etc/dwood3rc.custom" \
-v "`realpath $(CACHE)`:/var/cache/deadwood" \
-e "MARADNS_USER_ID=`id -u maradns`" \
$(PORT_ON_LOCALHOST) \
-d \
erwinnttdata/deadwood:$(VERSION)
endef

include ../make_utils/Makefile.help
include ../make_utils/Makefile.functions
include ../make_utils/Makefile.container

.PHONY +: run rerun rm clean test restart cache_permissions

run: $(CACHE) _localuser cache_permissions _run ##@default Starts the container. Set the option PORT_ON_LOCALHOST='-p 127.0.0.1:53:53/udp' to use the DNS server on localhost.

rerun: _rerun ##@target Stops and starts the container.

rm: _rm ##@target Stops and removes the container.

clean: _clean ##@target Stops and removes the container and removes all created files.

test: _test ##@target Tests if the container is running.
	
restart: _restart ##@target Restarts the container.

$(CACHE):
	mkdir -p "$(CACHE)"

cache_permissions:
	sudo chown -R maradns.maradns $(CACHE)
