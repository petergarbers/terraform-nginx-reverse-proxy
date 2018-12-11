## Sync to the state on S3
State storage is configured on files `terraform.backend.development`. Create new files for other environments

The following commands expect that you have configure an AWS cli profile named `bespoke` with admin access to the target AWS account.

* Execute `rm .terraform/*; terraform init -backend-config=terraform.backend.development`

## Use Terraform
* Dry-run with `terraform plan`
* (Danger) Apply with `terraform apply`

## Setup a new project
* Change the "key" value in the `terraform.backend.development` files to match the new project name.
* If the state for a new project or environment is stored on a different bucket, you need to change bucket, region and profile too.
* Create a proper `terraform.tfvars` by copying `terraform.tfvars.example`
* Init the state
