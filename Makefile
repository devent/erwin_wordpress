SHELL := /bin/bash
WEAVE := /usr/local/bin/weave
.DEFAULT_GOAL := setup
.PHONY: setup

include make_utils/Makefile.help

weave: ##@targets Installs and setups the weave network.
	cd weave && $(MAKE)

convoy: ##@targets Installs and setups the convoy volumes.
	cd convoy && $(MAKE)

db: setup ##@targets Installs and setups the database.
	cd mysql_container && $(MAKE)

setup: weave convoy ##@default Setups the weave network and convoy volumes.
	cd weave && $(MAKE)
	cd convoy && $(MAKE)
