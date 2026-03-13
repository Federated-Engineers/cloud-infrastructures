# locals {
#   oidc_issuer_url = aws_eks_cluster.federated-eks-cluster.identity[0].oidc[0].issuer
#   oidc_issuer     = replace(local.oidc_issuer_url, "https://", "")
# }


# resource "aws_iam_openid_connect_provider" "eks-oidc" {
#   url = local.oidc_issuer_url

#   client_id_list = ["sts.amazonaws.com"]

#   tags = {
#     Cluster   = aws_eks_cluster.federated-eks-cluster.name
#     ManagedBy = "terraform"
#   }
# }


# # Create a role for a Kubernetes service account
# data "aws_iam_policy_document" "eks-ebs-csi-trust" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Federated"
#       identifiers = [aws_iam_openid_connect_provider.eks-oidc.arn]
#     }

#     actions = ["sts:AssumeRoleWithWebIdentity"]

#     condition {
#       test     = "StringEquals"
#       variable = "${local.oidc_issuer}:sub"
#       values   = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
#     }

#     condition {
#       test     = "StringEquals"
#       variable = "${local.oidc_issuer}:aud"
#       values   = ["sts.amazonaws.com"]
#     }
#   }
# }

# data "aws_iam_policy" "ebs-csi-policy" {
#   arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
# }

# resource "aws_iam_role" "eks-ebs-csi-role" {
#   name               = "eks-ebs-csi-role"
#   assume_role_policy = data.aws_iam_policy_document.eks-ebs-csi-trust.json
# }

# resource "aws_iam_role_policy_attachment" "eks-ebs-policy-role-attach" {
#   role       = aws_iam_role.eks-ebs-csi-role.name
#   policy_arn = data.aws_iam_policy.ebs-csi-policy.arn
# }
