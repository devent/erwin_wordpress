WEAVE := /usr/local/bin/weave
.PHONY: run clean

run: $(WEAVE)
	$(WEAVE) launch

stop:
	$(WEAVE) stop

clean: stop
	sudo rm $(WEAVE)

$(WEAVE):
	curl -L git.io/weave -o /tmp/weave
	sudo mv /tmp/weave $(WEAVE)
	sudo chmod +x $(WEAVE)
	
