# resource "aws_iam_role" "eks-ng-role" {
#   name = "eks-node-group-role"

#   assume_role_policy = jsonencode({
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "ec2.amazonaws.com"
#       }
#     }]
#     Version = "2012-10-17"
#   })
# }

# resource "aws_iam_role_policy_attachment" "eks-demo-ng-WorkerNodePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.eks-ng-role.name
# }

# resource "aws_iam_role_policy_attachment" "eks-demo-ng-AmazonEKS_CNI_Policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.eks-ng-role.name
# }

# resource "aws_iam_role_policy_attachment" "eks-demo-ng-ContainerRegistryReadOnly" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.eks-ng-role.name
# }

# resource "aws_eks_node_group" "eks-demo-node-group" {
#   cluster_name    = aws_eks_cluster.federated-eks-cluster.id
#   node_role_arn   = aws_iam_role.eks-ng-role.arn
#   node_group_name = "demo-eks-node-group"
#   subnet_ids = [
#     aws_subnet.public-a.id,
#     aws_subnet.public-b.id
#   ]
#   scaling_config {
#     desired_size = 2
#     max_size     = 4
#     min_size     = 1
#   }

#   instance_types = ["c5n.xlarge", "c5.xlarge", "c7i.xlarge", "c8a.xlarge", "c6a.xlarge", "c5a.xlarge", "c8i.xlarge"]

#   capacity_type = "SPOT"
#   update_config {
#     max_unavailable = 1
#   }

#   tags = local.common_tags

#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     aws_iam_role_policy_attachment.eks-demo-ng-WorkerNodePolicy,
#     aws_iam_role_policy_attachment.eks-demo-ng-AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.eks-demo-ng-ContainerRegistryReadOnly,
#   ]
# }