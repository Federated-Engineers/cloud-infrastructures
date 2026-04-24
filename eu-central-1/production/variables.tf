variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-central-1"
}

variable "team" {
  description = "The team responsible for the deployment"
  type        = string
  default     = "Data Platform Team"
}

variable "environment" {
  description = "The environment for the deployment"
  type        = string
  default     = "production"
}

variable "project" {
  description = "The project owner"
  type        = string
  default     = "Federated-Engineers"
}

variable "eks_version" {
  type        = string
<<<<<<< HEAD
  default     = "1.34"
=======
  default     = "1.35"
>>>>>>> d61ce73 (changed k8s version)
  description = "EKS version"
}

variable "cidr_block" {
  type    = string
  default = "10.10.0.0/16"

}

variable "tags" {
  type = map(string)
  default = {
    terraform  = "true"
    kubernetes = "federated-eks-cluster"
  }
  description = "Tags to apply to all resources"
}