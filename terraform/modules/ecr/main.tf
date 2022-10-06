resource "aws_ecr_repository" "this" {
  for_each = {
    for k, v in var.repositories : k => v if !v.public
  }
  image_tag_mutability = each.value.image_tag_mutability
  force_delete         = each.value.force_delete
  image_scanning_configuration {
    scan_on_push = false
  }
  name = each.key
  tags = merge(var.tags, { "Name" = each.key })
}

resource "aws_ecr_lifecycle_policy" "this" {
  for_each = {
    for k, v in var.repositories : k => v if !v.public
  }
  repository = try(aws_ecr_repository.this[each.key].name, aws_ecrpublic_repository.this[each.key].name)
  policy = jsonencode({
    "rules" : [
      {
        "rulePriority" : 1,
        "description" : "Keep only ${each.value.image_count} image(s)",
        "selection" : {
          "tagStatus" : "any",
          "countType" : "imageCountMoreThan",
          "countNumber" : each.value.image_count
        },
        "action" : {
          "type" : "expire"
        }
      }
    ]
  })
}

resource "aws_ecrpublic_repository" "this" {
  for_each = {
    for k, v in var.repositories : k => v if v.public
  }
  provider        = aws.ecr-public
  repository_name = each.key

  catalog_data {
    architectures = ["x86-64"]
  }

  tags = merge(var.tags, { "Name" = each.key })
}
