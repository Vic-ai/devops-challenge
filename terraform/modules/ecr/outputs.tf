output "repositories" {
  description = "Repositories objects"
  value = {
    for k, v in merge(aws_ecrpublic_repository.this, aws_ecr_repository.this) : k => {
      url = try(aws_ecr_repository.this[k].repository_url, aws_ecrpublic_repository.this[k].repository_uri)
    }
  }
}
