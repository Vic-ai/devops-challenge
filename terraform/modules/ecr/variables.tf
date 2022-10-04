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

variable "repositories" {
  description = "Repositories to create"
  type = map(
    object({
      image_tag_mutability = optional(string, "MUTABLE")
      image_count          = optional(number, 3)
      force_delete         = optional(bool, false)
      public               = optional(bool, false)
    })
  )
}
