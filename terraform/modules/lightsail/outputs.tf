output "lightsail_container_services" {
  description = "Repositories objects"
  value = {
    for k, v in aws_lightsail_container_service.this : k => {
      url = aws_lightsail_container_service.this[k].url
    }
  }
}
