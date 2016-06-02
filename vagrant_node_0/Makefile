SHELL := /bin/bash
NODE_PRIVATE_NETWORK := 192.168.33.10
.PHONY: up provision destroy

up:
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
