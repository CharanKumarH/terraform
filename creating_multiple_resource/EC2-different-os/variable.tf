variable "ec2_config" {
    type = list(object({
    ami = string
    instance_type = string
  }))
}
