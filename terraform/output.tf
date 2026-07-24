output public_ip {
  value       = aws_instance.my_simple_terra_instance[*].public_ip
  description = "description"
}

