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
  default     = "1.35"
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