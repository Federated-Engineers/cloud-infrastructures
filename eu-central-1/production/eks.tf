# resource "aws_iam_role" "eks-cluster-role" {
#   name = "federated-engineers-eks-cluster-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "sts:AssumeRole",
#         ]
#         Effect = "Allow"
#         Principal = {
#           Service = "eks.amazonaws.com"

#         }
#       },
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.eks-cluster-role.name
# }

# resource "aws_eks_cluster" "federated-eks-cluster" {
#   name     = "federated-engineers-production"
#   role_arn = aws_iam_role.eks-cluster-role.arn
#   vpc_config {
#     endpoint_private_access = false
#     endpoint_public_access  = true
#     subnet_ids = [
#       aws_subnet.private-a.id,
#       aws_subnet.private-b.id,
#       aws_subnet.public-a.id,
#       aws_subnet.public-b.id
#     ]
#   }
#   access_config {
#     authentication_mode                         = "API"
#     bootstrap_cluster_creator_admin_permissions = true
#   }
#   bootstrap_self_managed_addons = true
#   tags                          = local.common_tags
#   version                       = var.eks_version
#   upgrade_policy {
#     support_type = "STANDARD"
#   }
#   depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy]
# }
