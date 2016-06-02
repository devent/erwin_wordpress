REPOSITORY := erwinnttdata
IMAGE_NAME := maradns
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
$(REPOSITORY)/$(NAME):$(VERSION)
endef

include ../make_container/Makefile

.PHONY +: clean reload config

run: $(WEAVE) $(CONF)
	eval "$$(weave env)"; \
	$(DOCKER_CMD)

$(CONF):
	mkdir -p "$(CONF)"
