

Since im working only with Azure DevOps Pipelines and Terraform Marketplace extension, its not neccesary to upload credentials as secret file in AzureDevOps


1. Install extension from Marketplace [Microsoft Terraform](https://marketplace.visualstudio.com/items?itemName=ms-devlabs.custom-terraform-tasks)

2. Create service account using AWS for Terraform, it will requiere Access Secret ID and Access Secret Key

3. Upload the files to Azure Repo for creating the terraform files, in this case is working for a EC2 and security group with key-pair and role. 
The state its saved in a S3 which is previously created as for the DynamoTable, however, theres another tf file to create those

4. Run the pipeline, it will ask for approvation once the plan is already done, it will show in the extensions vars 

![alt text](https://github.com/tatimun/TerraformRecipes/blob/main/TerraformAWS-AzureDevOps/image.png)

>**Status: In process**

Next steps:

Divide into AzureDevOps Pipeline for init and apply 
Release for Apply and add the destroy option only to approve people