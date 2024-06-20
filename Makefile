SHELL_SPEC_DIR ?= /var/tmp
TERRAFORM_VAR_FILE = values.auto.tfvars

.DEFAULT_GOAL := help

.PHONY: help
help:
	@grep -h -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: tf-version
tf-version: ## checks the terraform version
	terraform version

.PHONY: init
init: ## Init the terraform module
	terraform init

.PHONY: plan
plan: ## Outputs the Terraform plan
	terraform plan --var-file $(TERRAFORM_VAR_FILE)

.PHONY: show-plan
show-plan: ## Outputs the Terraform plan
	terraform plan -no-color -out=tfplan.out
	terraform show -json tfplan.out
	rm tfplan.out

.PHONY: graph
graph: ## make sure you install graphviz to use this command (https://graphviz.org/download/)
	terraform graph | dot -Tpng > graph.png

.PHONY: apply
apply: ## Applies Terraform plan w/ auto approve
	@test -s $(TERRAFORM_VAR_FILE) || { echo "The 'apply' rule assumes that variables are provided $(TERRAFORM_VAR_FILE)"; exit 1; }
	terraform apply -auto-approve --var-file $(TERRAFORM_VAR_FILE)

.PHONY: destroy
destroy: ## Destroys Terraform infrastructure w/ auto approve
	terraform destroy -auto-approve --var-file $(TERRAFORM_VAR_FILE)

.PHONY: clean
clean: ## Deletes temporary/generated files
	@rm -rf report .terraform terraform.tfstate terraform.tfstate.backup .terraform.lock.hcl graph.png modules/hcloud/kubeconfig/exec/setkubeconfig.sh modules/hcloud/kubeconfig/exec/unsetkubeconfig.sh ~/.kube/hcloud_config

.PHONY: lint
lint: init tf-version fmt ## Verifies Terraform syntax
	terraform validate

.PHONY: fmt
fmt: ## Reformats Terraform files accoring to standard
	terraform fmt -check -recursive -diff

.PHONY: test 
test: ## Runs ShellSpec tests
	shellspec --format document	

.PHONY: test-focus 
test-focus: ## Runs focused ShellSpec tests
	shellspec --focus --format document


## to install https://github.com/terraform-docs/terraform-docs#installation
.PHONY: markdown-table
markdown-table: ## Creates markdown tables for in- and output of this module
	terraform-docs markdown table .
			
