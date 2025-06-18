terraform {}

locals {
  value = "Hello, World! This is a test string."
}

variable "string_list" {
    description = "A list of strings"
    type        = list(string)
    default     = ["server_1", "server_2", "server_3"]
  
}

output "output_value" {
    value = {
        # # out put in upper case
        # upper_case_value = upper(local.value)

        # # out put in lower case 
        # lower_case_value = lower(local.value)

        # # out put in title case
        # title_case_value = title(local.value)

        # # out put in string list
        # string_list_value = join(", ", var.string_list)

        # # out put in string list with upper case
        # string_list_upper_case = join(", ", [for s in var.string_list : upper(s)])      

        # # out put in string list with lower case
        # string_list_lower_case = join(", ", [for s in var.string_list : lower(s)])
        
        # # out put in string list with title case
        # string_list_title_case = join(", ", [for s in var.string_list : title(s)])  

        # # out put in string list with length
        # string_list_length = length(var.string_list)

        # # out put in string list with first element
        # string_list_first_element = var.string_list[0]

        # # out put in string list with last element
        # string_list_last_element = var.string_list[length(var.string_list) - 1] 

        # # split the string into a list
        # split_string = split(" ", local.value)

        # # max value of string list
        # max_value = max(1,2,3,4,5,6,7,8,9,10)

        # # min value of string list
        # min_value = min(1,2,3,4,5,6,7,8,9,10)

        # # sum of string list
        # sum_value = sum([1,2,3,4,5,6,7,8,9,10])

        # # average of string list
        # average_value = length(var.string_list) > 0 ? sum([for s in var.string_list : length(s)]) / length(var.string_list) : 0

        # absolute_value 
        absolute_value = abs(-10)

        # startswith check
        startswith_check = startswith(local.value, "Hello")  


    }
  
}