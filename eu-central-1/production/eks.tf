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

# data "aws_caller_identity" "current" {}
# resource "aws_iam_role" "eks_infra_admin_role" {
#   name = "EKS-InfraTeam-AdminRole"

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#            AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
#         }
#       },
#     ]
#   })

#   tags = {
#     team = "infra-team"
#   }
# }

# data "aws_iam_group" "infra_team" {
#   group_name = "data-platform-team"
# }

# resource "aws_iam_group_policy" "allow_assume_eks_admin_role" {
#   name  = "AllowAssumeEKSInfraTeamAdminRole"
#   group = data.aws_iam_group.infra_team.group_name

#   policy = jsonencode({
#     Version = "2012-10-17"

#     Statement = [
#       {
#         Effect   = "Allow"
#         Action   = "sts:AssumeRole"
#         Resource = aws_iam_role.eks_infra_admin_role.arn
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy" "eks_infra_describe_cluster" {
#   name = "AllowDescribeEKSCluster"
#   role = aws_iam_role.eks_infra_admin_role.id

#   policy = jsonencode({
#     Version = "2012-10-17"

#     Statement = [
#       {
#         Sid      = "AllowDescribeCluster"
#         Effect   = "Allow"
#         Action   = "eks:DescribeCluster"
#         Resource = aws_eks_cluster.federated-eks-cluster.arn
#       }
#     ]
#   })
# }

# resource "aws_eks_access_entry" "infra_team" {
#   cluster_name  = aws_eks_cluster.federated-eks-cluster.name
#   principal_arn = aws_iam_role.eks_infra_admin_role.arn
#   type          = "STANDARD"
# }

# resource "aws_eks_access_policy_association" "infra_team_admin" {
#   cluster_name  = aws_eks_cluster.federated-eks-cluster.name
#   principal_arn = aws_iam_role.eks_infra_admin_role.arn

#   policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

#   access_scope {
#     type = "cluster"
#   }

#   depends_on = [
#     aws_eks_access_entry.infra_team
#   ]
# }