variable "aws_region" {
  description = "AWS region"
  type        = string
  nullable    = false
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

  validation {
    condition     = alltrue([for k, v in var.repositories: false if v.image_count < 3 && !v.public])
    error_message = "image_count can not be lower than 3"
  }
}
