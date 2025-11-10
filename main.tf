provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "aidevops_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet1" {
  cidr_block = var.public_subnet1_cidr
  vpc_id     = aws_vpc.aidevops_vpc.id
  availability_zone = "us-east-1a"
  tags = {
    Name = var.public_subnet1_name
  }
}

resource "aws_subnet" "public_subnet2" {
  cidr_block = var.public_subnet2_cidr
  vpc_id     = aws_vpc.aidevops_vpc.id
  availability_zone = "us-east-1b"
  tags = {
    Name = var.public_subnet2_name
  }
}

resource "aws_internet_gateway" "aidevops_igw" {
  vpc_id = aws_vpc.aidevops_vpc.id
  tags = {
    Name = "aidevops-igw"
  }
}

resource "aws_route_table" "aidevops_rt" {
  vpc_id = aws_vpc.aidevops_vpc.id
  tags = {
    Name = "aidevops-rt"
  }
}

resource "aws_route" "aidevops_rt_igw" {
  route_table_id         = aws_route_table.aidevops_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.aidevops_igw.id
}

resource "aws_route_table_association" "aidevops_rt_subnet1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.aidevops_rt.id
}

resource "aws_route_table_association" "aidevops_rt_subnet2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.aidevops_rt.id
}

resource "aws_security_group" "aidevops_sg" {
  name        = var.security_group_name
  description = "EKS Security Group"
  vpc_id      = aws_vpc.aidevops_vpc.id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.security_group_name
  }
}

resource "aws_iam_role" "aidevops_eks_cluster" {
  name        = "aidevops-eks-cluster-role"
  description = "EKS Cluster Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "aidevops_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.aidevops_eks_cluster.name
}

resource "aws_iam_role" "aidevops_eks_node" {
  name        = "aidevops-eks-node-role"
  description = "EKS Node Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "aidevops_eks_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.aidevops_eks_node.name
}

resource "aws_iam_role_policy_attachment" "aidevops_eks_container_registry_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.aidevops_eks_node.name
}

resource "aws_eks_cluster" "aidevops_eks_cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.aidevops_eks_cluster.arn
  vpc_config {
    subnet_ids = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
    security_group_ids = [aws_security_group.aidevops_sg.id]
  }
  depends_on = [
    aws_iam_role_policy_attachment.aidevops_eks_cluster_policy
  ]
}

resource "aws_eks_node_group" "aidevops_eks_node_group" {
  cluster_name    = aws_eks_cluster.aidevops_eks_cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.aidevops_eks_node.arn
  instance_types = [var.node_type]
  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_size
    min_size     = var.min_size
  }
  depends_on = [
    aws_iam_role_policy_attachment.aidevops_eks_node_policy,
    aws_iam_role_policy_attachment.aidevops_eks_container_registry_policy
  ]
}