WEAVE := /usr/local/bin/weave
.DEFAULT_GOAL := run
.PHONY: run clean

include ../make_utils/Makefile.help

run: $(WEAVE) ##@default Installs and starts the weave network.
	if ! $(WEAVE) status; then \
	$(WEAVE) launch; \
	fi

test: $(WEAVE) ##@targets Tests if the weave network is active.
	$(WEAVE) status

stop: test ##@targets Stops the weave network.
	$(WEAVE) stop

clean: stop ##@targets Stops and removes the weave network.
	sudo rm $(WEAVE)

$(WEAVE):
	curl -L git.io/weave -o /tmp/weave
	sudo mv /tmp/weave $(WEAVE)
	sudo chmod +x $(WEAVE)
	
