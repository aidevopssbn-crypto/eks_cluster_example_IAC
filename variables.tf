variable "vpc_name" {
  type = string
  default = "aidevops-vpc-eks"
}

variable "vpc_cidr" {
  type = string
  default = "10.130.0.0/16"
}

variable "public_subnet1_name" {
  type = string
  default = "aidevops-vpc-eks-pubsubnet1"
}

variable "public_subnet1_cidr" {
  type = string
  default = "10.130.10.0/24"
}

variable "public_subnet2_name" {
  type = string
  default = "aidevops-vpc-eks-pubsubnet2"
}

variable "public_subnet2_cidr" {
  type = string
  default = "10.130.20.0/24"
}

variable "security_group_name" {
  type = string
  default = "aidevops-sg-eks"
}

variable "eks_cluster_name" {
  type = string
  default = "aidevops-eks-cluster"
}

variable "node_group_name" {
  type = string
  default = "aidevops-eks-nodegrp"
}

variable "node_type" {
  type = string
  default = "t3.medium"
}

variable "desired_capacity" {
  type = number
  default = 2
}

variable "max_size" {
  type = number
  default = 3
}

variable "min_size" {
  type = number
  default = 1
}