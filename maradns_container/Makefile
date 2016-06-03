VERSION := latest
NAME := maradns
CONF := ../root/etc/maradns

define DOCKER_CMD :=
docker run \
--name $(NAME) \
--dns=172.17.0.1 \
-v "`realpath mararc`:/etc/mararc" \
-v "`realpath $(CONF)`:/etc/maradns" \
-p 8053:172.17.0.2:53 \
-d \
erwinnttdata/maradns:$(VERSION)
endef

include ../make_container/Makefile

.PHONY +: run rerun rm clean test restart

run: $(CONF) _run

rerun: _rerun

rm: _rm

clean: _clean

test: _test
	
restart: _restart

$(CONF):
	mkdir -p "$(CONF)"
