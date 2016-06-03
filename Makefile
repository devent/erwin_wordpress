SHELL := /bin/bash
WEAVE := /usr/local/bin/weave
.DEFAULT_GOAL := all
.PHONY: all

all:
	cd weave; $(MAKE)
	cd convoy; $(MAKE)
