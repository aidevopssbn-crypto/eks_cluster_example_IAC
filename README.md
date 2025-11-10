# Terraform Configuration for AWS EKS Cluster
This Terraform configuration creates an AWS EKS Cluster with a managed node group, along with the necessary networking components.

## Step 1: Prerequisites
* Install Terraform
* Configure AWS credentials

## Step 2: Create Terraform Configuration Files
Create the following files:
* `main.tf`: defines the resources to be created
* `variables.tf`: defines the input variables
* `output.tf`: defines the output values

## Step 3: Define Input Variables
In `variables.tf`, define the input variables:
* AWS region
* VPC CIDR
* Public subnet CIDRs
* EKS cluster name
* Node group name

## Step 4: Create VPC and Networking Components
In `main.tf`, create:
* VPC
* Public subnets
* Internet Gateway
* Route Table
* Route Table Associations

## Step 5: Create EKS Cluster
In `main.tf`, create:
* EKS cluster
* EKS cluster IAM role
* Managed node group

## Step 6: Configure Security Group
In `main.tf`, create:
* Security group
* Inbound rules for EKS API and Kubelet
* Outbound rule for all ports

## Step 7: Output Values
In `output.tf`, define the output values:
* EKS cluster name
* EKS cluster endpoint
* EKS cluster ARN
* Node group name
* VPC ID
* Subnet IDs

## Step 8: Apply Terraform Configuration
Run `terraform apply` to create the resources

## Example Usage
* Clone the repository
* Update the input variables in `variables.tf`
* Run `terraform apply` to create the resources
* Verify the output values in the Terraform output