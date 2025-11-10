output "eks_cluster_name" {
  value = aws_eks_cluster.aidevops_eks_cluster.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.aidevops_eks_cluster.endpoint
}

output "eks_cluster_arn" {
  value = aws_eks_cluster.aidevops_eks_cluster.arn
}

output "node_group_name" {
  value = aws_eks_node_group.aidevops_eks_node_group.node_group_name
}

output "vpc_id" {
  value = aws_vpc.aidevops_vpc.id
}

output "subnet_ids" {
  value = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
}