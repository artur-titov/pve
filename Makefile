# ---------------------------------------------------------------------+
# File variables
#
ALL_VARS_FILE=ansible/inventories/group_vars/all.yml
HOSTS_BOOTSTRAP_FILE=ansible/inventories/hosts_bootstrap.yml


# ---------------------------------------------------------------------+
# Call to 'help' section with 'make' command
help:
	@echo "\nSupported commands:"
	@echo ""
	@echo "- make lint                        : Lint your Ansible files."
	@echo "- make view-vars                   : View variables."
	@echo "- make encrypt-vars                : Encrypt variables file."
	@echo "- make decrypt-vars                : Decrypt variables file."
	@echo "- make edit-vars                   : Edit variables file."
	@echo ""
	@echo "- make bootstrap-ping              : Ping new node before bootstrapping."
	@echo "- make bootstrap                   : Setup new node in your homelab."
	@echo ""
	@echo "- make site                        : Play your site.yml file."
	@echo "- make site GROUP=<group_name>     : Play your site.yml file with limits."
	@echo "\n"


# ---------------------------------------------------------------------+
# Lint
#
lint:
	ansible-lint


# ---------------------------------------------------------------------+
# Work with ansible-vault
#
view-vars:
	ansible-vault view ${ALL_VARS_FILE}

edit-vars:
	ansible-vault edit ${ALL_VARS_FILE}

encrypt-vars:
	ansible-vault encrypt ${ALL_VARS_FILE}

decrypt-vars:
	ansible-vault decrypt ${ALL_VARS_FILE}


bootstrap-ping:
	ansible all -i ${HOSTS_BOOTSTRAP_FILE} -m ping --ask-pass

bootstrap:
	ansible-playbook ansible/node_bootstrap.ansible.yml -i ${HOSTS_BOOTSTRAP_FILE}


# ---------------------------------------------------------------------+
# Main Ansible command
#
site: # GROUP
ifdef GROUP
	ansible-playbook ansible/site.yml --limit ${GROUP}
else
	ansible-playbook ansible/site.yml
endif
