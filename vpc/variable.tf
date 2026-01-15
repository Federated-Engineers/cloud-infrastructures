

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for federated engineers VPC"
  type        = string
  default     = "30.0.0.0/16"
}

variable "public_subnets" {
  description = "Map of public subnets with CIDR and AZ"
  type        = map(any)
  default = {
    public1 = { cidr_block = "30.0.0.0/20", availability_zone = "eu-central-1a" }
    public2 = { cidr_block = "30.0.16.0/20", availability_zone = "eu-central-1b" }
    public3 = { cidr_block = "30.0.32.0/20", availability_zone = "eu-central-1c" }
  }
}

variable "private_subnets" {
  description = "Map of private subnets with CIDR and AZ"
  type        = map(any)
  default = {
    private1 = { cidr_block = "30.0.128.0/20", availability_zone = "eu-central-1a" }
    private2 = { cidr_block = "30.0.144.0/20", availability_zone = "eu-central-1b" }
    private3 = { cidr_block = "30.0.160.0/20", availability_zone = "eu-central-1c" }
  }
}

variable "private_route_tables" {
  description = "Map of private route tables"
  type        = map(any)
  default = {
    private1 = { name = "private1-eu-central-1a" }
    private2 = { name = "private2-eu-central-1b" }
    private3 = { name = "private3-eu-central-1c" }
  }
}

variable "team" {
  description = "The team responsible for the deployment"
  type        = string
  default     = "Data platform engineering team"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "federated engineers"
}

variable "environment" {
  description = "The environment for the deployment"
  type        = string
  default     = "production"
}

variable "service" {
    description = "The service name"
    type        = string
    default     = "VPC"
  
}