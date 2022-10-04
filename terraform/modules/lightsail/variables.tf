variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "create" {
  description = "Do you want to create resource or not"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Map of tags attached to resources"
  type        = map(string)
}

variable "applications" {
  description = "Applications to deploy in lightsail"
  type = map(
    object({
      version = optional(string, "latest")
      port    = optional(number, 80)
    })
  )
}

variable "secret" {
  description = "Super secret value"
  type        = string
  sensitive   = true
}

variable "repositories" {
  description = "ECR repositories"
  type = map(
    object({
      url = string
    })
  )
}
