# # Create a role for a Kubernetes service account
# data "aws_iam_policy_document" "eks-forge-airflow-trust" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Federated"
#       identifiers = [aws_iam_openid_connect_provider.eks-oidc.arn]
#     }

#     actions = ["sts:AssumeRoleWithWebIdentity"]

#     condition {
#       test     = "StringLike"
#       variable = "${local.oidc_issuer}:sub"
#       values   = ["system:serviceaccount:forge-airflow:*"]
#     }

#     # condition {
#     #   test     = "StringEquals"
#     #   variable = "${local.oidc_issuer}:aud"
#     #   values   = ["sts.amazonaws.com"]
#     # }
#   }
# }

# data "aws_iam_policy" "forge-airflow-policy" {
#   arn = "arn:aws:iam::049417293525:policy/forge-airflow-access-policy"
# }

# resource "aws_iam_role" "eks-forge-airflow-role" {
#   name               = "eks-forge-airflow-role"
#   assume_role_policy = data.aws_iam_policy_document.eks-forge-airflow-trust.json
# }

# resource "aws_iam_role_policy_attachment" "eks-forge-airflow-policy-role-attach" {
#   role       = aws_iam_role.eks-forge-airflow-role.name
#   policy_arn = data.aws_iam_policy.forge-airflow-policy.arn
# }
