variable aws_instance_type {
  type        = string
  default     = "t3.micro"
  description = "This has the info about my instance type"
}
variable  aws_availability_zone {
  type        = string
  default     = "us-west-2a"
  description = "Aws region of my insatnce"
}
variable server_count {
  type        = number
  default     = "3"
  description = "No of Instance creating"
}

