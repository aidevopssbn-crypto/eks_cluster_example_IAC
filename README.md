# Getting Started with Terraform Configuration for Amazon EKS Cluster
This repository contains Terraform configuration files to create an Amazon EKS Cluster with necessary networking components and node groups.

## Prerequisites
* Terraform installed on your machine
* AWS account with necessary permissions

## Step-by-Step Instructions
1. Clone the repository to your local machine.
2. Navigate to the repository directory.
3. Initialize the Terraform working directory by running `terraform init`.
4. Review and update the `variables.tf` file if necessary.
5. Apply the Terraform configuration by running `terraform apply`.
6. Verify the resources created in your AWS account.

## Terraform Configuration Files
* `main.tf`: Defines the main resources, including VPC, subnets, internet gateway, route table, security group, EKS cluster, and node group.
* `variables.tf`: Defines the input variables for the Terraform configuration.
* `output.tf`: Defines the output values, including EKS cluster name, endpoint, ARN, node group name, VPC ID, and subnet IDs.

## Resources Created
* VPC
* Internet Gateway
* Public Subnets (2)
* Route Table
* Security Group
* EKS Cluster
* Node Group

## Output Values
* EKS Cluster Name
* EKS Cluster Endpoint
* EKS Cluster ARN
* Node Group Name
* VPC ID
* Subnet IDs