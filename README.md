This repository uses Terraform to create Backstage infrastructures on AWS

Run terraform init: terraform init -var-file=vars/dev.tfvars -backend-config=vars/dev.backend.tfvars

Run terraform plan: terraform plan -var-file=vars/dev.tfvars

Run terraform apply: terraform apply -var-file=vars/dev.tfvars