resource "aws_lightsail_container_service" "this" {
  for_each = var.create ? var.applications : {}
  name     = each.key
  power    = "nano"
  scale    = 1

  tags = merge(var.tags, { "Name" = each.key })
}

resource "aws_lightsail_container_service_deployment_version" "this" {
  for_each = var.create ? var.applications : {}

  container {
    container_name = each.key
    image          = format("%s:%s", var.repositories[each.key].url, each.value.version)

    environment = {
      HOST   = "0.0.0.0"
      PORT   = each.value.port
      SECRET = var.secret
    }

    ports = {
      (each.value.port) = "HTTP"
    }
  }

  public_endpoint {
    container_name = each.key
    container_port = each.value.port

    health_check {
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout_seconds     = 2
      interval_seconds    = 5
      path                = "/"
      success_codes       = "200-499"
    }
  }

  service_name = aws_lightsail_container_service.this[each.key].name
}
