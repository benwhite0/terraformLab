variable "environment" {
  description = "The environment to deploy the resources to"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "The project to deploy the resources to"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}