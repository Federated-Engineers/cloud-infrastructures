# resource "aws_eks_addon" "metrics-server" {
#   cluster_name  = aws_eks_cluster.federated-eks-cluster.id
#   addon_name    = "metrics-server"
#   addon_version = "v0.8.1-eksbuild.1" #e.g., previous version v1.9.3-eksbuild.3 and the new version is v1.10.1-eksbuild.1
#   depends_on = [ aws_eks_node_group.eks-demo-node-group ]
# }

# resource "aws_eks_addon" "ebs-csi-driver" {
#   cluster_name             = aws_eks_cluster.federated-eks-cluster.id
#   addon_name               = "aws-ebs-csi-driver"
#   addon_version            = "v1.56.0-eksbuild.1" #e.g., previous version v1.9.3-eksbuild.3 and the new version is v1.10.1-eksbuild.1
#   service_account_role_arn = aws_iam_role.eks-ebs-csi-role.arn
#   depends_on = [ aws_eks_node_group.eks-demo-node-group ]
# }