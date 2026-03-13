# # Create a role for a Kubernetes service account
# data "aws_iam_policy_document" "eks-elite-airflow-trust" {
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
#       values   = ["system:serviceaccount:elite-airflow:*"]
#     }

#     # condition {
#     #   test     = "StringEquals"
#     #   variable = "${local.oidc_issuer}:aud"
#     #   values   = ["sts.amazonaws.com"]
#     # }
#   }
# }

# data "aws_iam_policy" "elite-airflow-policy" {
#   arn = "arn:aws:iam::049417293525:policy/elite-airflow-access-policy"
# }

# resource "aws_iam_role" "eks-elite-airflow-role" {
#   name               = "eks-elite-airflow-role"
#   assume_role_policy = data.aws_iam_policy_document.eks-elite-airflow-trust.json
# }

# resource "aws_iam_role_policy_attachment" "eks-elite-airflow-policy-role-attach" {
#   role       = aws_iam_role.eks-elite-airflow-role.name
#   policy_arn = data.aws_iam_policy.elite-airflow-policy.arn
# }
