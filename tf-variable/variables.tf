variable "aws_instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t2.micro"
validation {
  condition = var.aws_instance_type == "t2.micro" || var.aws_instance_type == "t2.nano"|| var.aws_instance_type == "t3.micro" || var.aws_instance_type == "t3.nano"
  error_message = "The instance type must be either 't2.micro' or 't2.nano'."
}


  
}


variable "aws_root_block_device" {

    type = object({
        v_size = number
        v_type = string
    })

    default = {
        v_size = 20
        v_type = "gp2"
    }
  

}


variable "additional_tags" {
  description = "Additional tags to apply to the instance"
  type        = map(string)
  default     = {}
}





