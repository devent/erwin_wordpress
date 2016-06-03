VERSION := 0.5.0-rc1
CONVOY := /usr/local/bin/convoy /usr/local/bin/convoy-pdata_tools
CONVOY_SPEC := /etc/docker/plugins/convoy.spec
SERVICE := /etc/systemd/system/convoy.service
DATA_VOL := /volumes/data.vol
METADATA_VOL := /volumes/metadata.vol
.PHONY: install clean

install: $(CONVOY) $(SERVICE) enable start

clean:
	sudo rm $(CONVOY); true
	sudo rm $(CONVOY_SPEC); true
	sudo systemctl stop convoy.service; true
	sudo systemctl disable convoy.service; true
	sudo rm $(SERVICE); true

enable: $(SERVICE)
	sudo systemctl enable convoy.service
	
start: $(DATA_VOL) $(METADATA_VOL)
	sudo losetup /dev/loop5 $(DATA_VOL)
	sudo losetup /dev/loop6 $(METADATA_VOL)
	sudo systemctl start convoy.service
	sudo systemctl status convoy.service
	
$(CONVOY):
	if [ ! -f "/tmp/convoy.tar.gz" ]; then \
	curl -L https://github.com/rancher/convoy/releases/download/v$(VERSION)/convoy.tar.gz -o /tmp/convoy.tar.gz; \
	fi
	cd /tmp && tar xf convoy.tar.gz
	sudo cp /tmp/convoy/convoy /tmp/convoy/convoy-pdata_tools /usr/local/bin/
	sudo chmod +x $(CONVOY)
	rm -rf /tmp/convoy /tmp/convoy.tar.gz
	sudo mkdir -p /etc/docker/plugins
	sudo bash -c "echo \"unix:///var/run/convoy/convoy.sock\" | tee $(CONVOY_SPEC)"

$(SERVICE):
	sudo cp convoy.service $(SERVICE)
	sudo systemctl daemon-reload

$(DATA_VOL):
	sudo mkdir -p /volumes
	sudo truncate -s 4G /volumes/data.vol

$(METADATA_VOL):
	sudo mkdir -p /volumes
	sudo truncate -s 256M /volumes/metadata.vol
