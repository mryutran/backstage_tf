This repository uses Terraform to create Backstage infrastructures on AWS

Follow the steps below to build docker image and run terraform on your local machine:

Export your aws credentials.

Build and Tag Docker Image:
Build docker image: docker build . -f packages/backend/Dockerfile --tag backstage --no-cache
docker tag backstage 631669505728.dkr.ecr.us-east-1.amazonaws.com/backstage-image:1.0.2

Authenticate Docker to the ECR Registry:
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 631669505728.dkr.ecr.us-east-1.amazonaws.com

Push Docker Image to ECR:
docker push 631669505728.dkr.ecr.us-east-1.amazonaws.com/backstage-image:1.0.2

Update dev.tfvars: docker_image_tag    = "1.0.2" 

Run terraform init: terraform init -var-file=vars/dev.tfvars -backend-config=vars/dev.backend.tfvars

Run terraform plan: terraform plan -var-file=vars/dev.tfvars

Run terraform apply: terraform apply -var-file=vars/dev.tfvars

My Backstage: http://backstage-alb-1540112729.us-east-1.elb.amazonaws.com/catalog