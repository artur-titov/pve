help:
	@echo "\nSupported commands:"
	@echo "---------------------------------------------------------------------------------+"
	@echo "- make lint                               : Lint your Ansible files."
	@echo "- make group-vars-view FILE=<file_name>   : Lint your Ansible files."
	@echo ""
	@echo "- make bootstrap-ping                     : Ping new node before bootstrapping."
	@echo "- make bootstrap                          : Setup new node in your homelab."
	@echo ""
	@echo "- make site                               : Play your site.yml file."
	@echo "- make site GROUP=<group_name>            : Play your site.yml file with limits."
	@echo "---------------------------------------------------------------------------------+\n"

lint:
	ansible-lint

group-vars-view: #FILE
	ansible-vault view ansible/inventories/group_vars/${FILE}.yml

bootstrap-ping:
	ansible all -i ansible/inventories/hosts_bootstrap.yml -m ping --ask-pass

bootstrap:
	ansible-playbook ansible/node_bootstrap.ansible.yml -i inventories/hosts_bootstrap.yml

site: # GROUP
ifdef GROUP
	ansible-playbook ansible/site.yml --limit ${GROUP}
else
	ansible-playbook ansible/site.yml
endif
