output "eks_cluster_name" {
  value = aws_eks_cluster.this.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "eks_cluster_arn" {
  value = aws_eks_cluster.this.arn
}

output "node_group_name" {
  value = aws_eks_node_group.this.node_group_name
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnet_ids" {
  value = [aws_subnet.pubsubnet1.id, aws_subnet.pubsubnet2.id]
}