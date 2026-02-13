variable "environment" {
  description = "The environment to deploy the resources to"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "The project to deploy the resources to"
  type        = string
  default     = "terraformLab"
}
