# ---------------------------------------------------------------------+
# File variables
#
# Absible:
ALL_VARS_FILE        = ansible/inventories/group_vars/all.yml
HOSTS_BOOTSTRAP_FILE = ansible/inventories/hosts_bootstrap.yml
SITE_FILE            = ansible/site.yml
BOOTSTRAP_FILE       = ansible/node_bootstrap.ansible.yml
# Terraform:
TF_DIRECTORY         = terraform
TFVARS_FILE          = variables.tfvars


# ---------------------------------------------------------------------+
# Call to 'help' section with 'make' command
help:
	@echo "\nSupported commands:"
	@echo ""
	@echo "Ping new node with Ansible:"
	@echo "- make bootstrap-ping            : Ping new node before bootstrapping."
	@echo "- make bootstrap                 : Setup new node in your homelab."
	@echo ""
	@echo "Ansible commands:"
	@echo "- make ansible-lint              : Lint your Ansible files."
	@echo "- make view-vars                 : View Ansible variables."
	@echo "- make edit-vars                 : Edit Ansible variables file."
	@echo "- make encrypt-vars              : Encrypt Ansible variables file."
	@echo "- make decrypt-vars              : Decrypt Ansible variables file."
	@echo "- make site                      : Play your site.yml file."
	@echo "- make site GROUP=<group_name>   : Play your site.yml file with limits."
	@echo ""
	@echo "Terraform commands:"
	@echo "- make tf-init                   : Terraform init."
	@echo "- make tf-validate               : Validate Terraform files."
	@echo "- make tf-plan                   : Plan Terraform infrastructure."
	@echo "- make tf-apply                  : Apply Terraform infrastructure."
	@echo "- make tf-destroy                : Destroy Terraform infrastructure."
	@echo "\n"


# ---------------------------------------------------------------------+
# Ping new node with Ansible
#
bootstrap-ping:
	ansible all -i ${HOSTS_BOOTSTRAP_FILE} -m ping --ask-pass

bootstrap:
	ansible-playbook ${BOOTSTRAP_FILE} -i ${HOSTS_BOOTSTRAP_FILE}


# ---------------------------------------------------------------------+
# Ansible commands
#
ansible-lint:
	ansible-lint

view-vars:
	ansible-vault view ${ALL_VARS_FILE}

edit-vars:
	ansible-vault edit ${ALL_VARS_FILE}

encrypt-vars:
	ansible-vault encrypt ${ALL_VARS_FILE}

decrypt-vars:
	ansible-vault decrypt ${ALL_VARS_FILE}

site: # GROUP
ifdef GROUP
	ansible-playbook ${SITE_FILE} --limit ${GROUP}
else
	ansible-playbook ${SITE_FILE}
endif


# ---------------------------------------------------------------------+
# Terraform commands
#
tf-init:
	terraform -chdir=${TF_DIRECTORY} init

tf-validate:
	terraform -chdir=${TF_DIRECTORY} validate

tf-plan:
	terraform -chdir=${TF_DIRECTORY} plan -var-file="${TFVARS_FILE}"

tf-apply:
	terraform -chdir=${TF_DIRECTORY} apply -var-file="${TFVARS_FILE}"

tf-destroy:
	terraform -chdir=${TF_DIRECTORY} destroy -var-file="${TFVARS_FILE}"
