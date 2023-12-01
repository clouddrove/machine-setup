USERNAME := $(shell whoami)

.ONESHELL:
install:
	./scripts/install.sh play

.ONESHELL:
install-changed:
	./scripts/install.sh play changed


requirements:
	pip install --upgrade pip
	pip3 install -r roles/common/files/requirements.txt

debug:
	ansible-playbook \
		--user ${USERNAME} \
		--inventory inventory/hosts.yaml \
		--tags debug \
		playbooks/machine_setup.yaml

