SHELL := /bin/bash
WEAVE := /usr/local/bin/weave
.DEFAULT_GOAL := setup
.PHONY: setup weave convoy db dns elk-stack muellerpublic_de node_0

include make_utils/Makefile.help

setup: weave convoy ##@default Setups the weave network and convoy volumes.
	cd weave && $(MAKE)
	cd convoy && $(MAKE)

weave: ##@targets Installs and setups the weave network.
	cd weave && $(MAKE)

convoy: ##@targets Installs and setups the convoy volumes.
	cd convoy && $(MAKE)

db: setup ##@targets Installs and setups the database.
	cd mysql_container && $(MAKE)

dns: setup ##@targets Installs and setups the authorative DNS server.
	cd maradns_container && $(MAKE)

elk-stack: setup ##@targets Installs and setups the ELK-stack.
	cd elasticsearch_container && $(MAKE)
	cd kibana-container && $(MAKE)

wp_muellerpublic: setup ##@targets Installs and setups wordpress.muellerpublic.nttdata.com Wordpress site.
	cd mysql_container && $(MAKE) user DB_USER=wp_muellerpublic DB_PASSWORD=1234 DB_HOST=wp_muellerpublic.weave.local DB_NAME=wp_muellerpublic
	cd wp_muellerpublic_container && $(MAKE) build
	cd wp_muellerpublic_container && $(MAKE)

frontend: setup ##@targets Installs and setups the http frontend.
	cd nginx_frontend_container && $(MAKE)

node_0: ##@targets Creates Node-0 virtual server.
	cd vagrant_node_0 && $(MAKE)
