NODE_PRIVATE_NETWORK ?= 192.168.33.10
.DEFAULT_GOAL := up

include ../make_utils/Makefile.functions
include ../make_utils/Makefile.help

.PHONY +: up provision clean update

up:
	$(call check_defined, NODE_PRIVATE_NETWORK, Node private network.)
	if [ -z "`vagrant plugin list|grep 'vagrant-vbguest (0.11.0)'`" ]; then \
		vagrant plugin install vagrant-vbguest; \
	fi
	if [ -z "`vagrant plugin list|grep 'vagrant-proxyconf (1.5.2)'`" ]; then \
	vagrant plugin install vagrant-proxyconf; \
	fi
	export vagrant_private_network="$(NODE_PRIVATE_NETWORK)"; \
	vagrant up

provision:
	vagrant provision

clean:
	vagrant destroy
	
update:
	vagrant box update
