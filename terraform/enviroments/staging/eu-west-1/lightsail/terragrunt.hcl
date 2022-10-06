terraform {
  source = format("%s/modules//lightsail", find_in_parent_folders("terraform/"))
}

inputs = {
  repositories = dependency.ecr.outputs.repositories
}

include {
  path = find_in_parent_folders("template.hcl")
}

dependency "ecr" {
  config_path = "../ecr"
}
