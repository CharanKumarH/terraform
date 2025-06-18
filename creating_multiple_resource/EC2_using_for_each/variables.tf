variable "ec2_config" {
  type = list(object({
    ami            = string
    instance_type = string
  }))
  
}

variable "ec2_map" {
    # This variable is used to define a map of EC2 instances with their configurations.
    # key=value (ami, instance_type)
  
  type = map(object({
    ami            = string
    instance_type = string
  }))
  
}