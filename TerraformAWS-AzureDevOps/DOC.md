# General Configuration
Trigger: Executes on the main branch.

Pool: Uses an ubuntu-latest virtual machine.

Resources: Repository as the source of infrastructure configuration.

Variables
Defines variables for the repository name, Git username and email, and Terraform version (1.9.7).

# Stages
Init - Initialize Terraform

Description: Initializes Terraform without backend. Steps:

# Installs Terraform.
Runs terraform init -backend=false to initialize without backend.

Validate - Configuration Validation

Description: Validates Terraform configuration.

Steps:

a. Installs Terraform.

b. Runs terraform validate to ensure configuration is valid.

Plan - Generate Plan
Description: Generates the Terraform deployment plan and saves it as an artifact.

Steps:

a. Installs Terraform.

b. Runs terraform plan -out=tfplan to generate the plan file.

c. Publishes the Terraform artifacts (tfplan, .terraform, .terraform.lock.hcl) for use in subsequent stages.

Approval - Manual Approval

Description: Waits for manual approval to proceed with deployment.

Steps:

a. Waits for approval.

Timeout of 60 minutes.

Apply - Apply Infrastructure
Description: Applies infrastructure based on the approved plan.

Steps:

a. Downloads published artifacts (tfplan, terraform-lock, terraform-providers).

b. Runs terraform apply -auto-approve tfplan to apply the infrastructure.
