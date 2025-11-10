variable "aws_region" {
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.110.0.0/16"
}

variable "pubsubnet1_cidr" {
  type        = string
  default     = "10.110.10.0/24"
}

variable "pubsubnet2_cidr" {
  type        = string
  default     = "10.110.20.0/24"
}

variable "eks_cluster_name" {
  type        = string
  default     = "aidevops-eks-cluster"
}

variable "node_group_name" {
  type        = string
  default     = "aidevops-eks-nodegrp"
}

variable "instance_type" {
  type        = string
  default     = "t3.medium"
}

variable "desired_size" {
  type        = number
  default     = 2
}

variable "max_size" {
  type        = number
  default     = 3
}

variable "min_size" {
  type        = number
  default     = 1
}