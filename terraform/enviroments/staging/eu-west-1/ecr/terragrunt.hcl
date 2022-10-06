terraform {
  source = format("%s/modules//ecr", find_in_parent_folders("terraform/"))
}

include {
  path = find_in_parent_folders("template.hcl")
}
