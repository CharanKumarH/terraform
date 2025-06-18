terraform {

}

# number list

variable "num_list" {
  description = "A list of numbers"
  type        = list(number)
  default     = [1, 2, 3, 4, 5]

}

# object list person

variable "person_list" {
  description = "A list of persons"
  type = list(object({
    fname = string
    lname = string
    age   = number
  }))

  default = [{
    fname = "John"
    lname = "Doe"
    age   = 30
    }, {
    fname = "Jane"
    lname = "Smith"
    age   = 25
    }, {
    fname = "Alice"
    lname = "Johnson"
    age   = 28
  }]

}

# map list 
variable "map_list" {
  type = map(number)
  default = {
    "one"   = 1
    "two"   = 2
    "three" = 3
    "four"  = 4
    "five"  = 5

  }

}



# local variables for arithmetic operations
locals {
  add = 5 + 10
  sub = 10 - 5
}

# calculation 



output "result" {
  value = {

    # arithmetic operations
    addition       = 5 + 10
    subtraction    = 10 - 5
    multiplacation = 5 * 10
    division       = 10 / 2
    modulus        = 10 % 3
    exponentiation = pow(2, 3)

    # accessing map variable
    map_list = var.map_list


    # accessing variable
    num_list = var.num_list



    # accessing object list variable
    person_list = var.person_list


    # accessing local variables
    local_var = local.add
    local_sub = local.sub


    # accessing for loop variable
    num_list_multiplied = [for num in var.num_list : num * 5]


    # accessing for loop variable
    for_loop_result = [for person in var.person_list : "${person.fname} ${person.lname} is ${person.age} years old."]


    # odd number 
    odd_number = [for num in var.num_list : num if num % 2 != 0]

    # even number
    even_number = [for num in var.num_list : num if num % 2 == 0]

    # map list
    map_list = [for key, value in var.map_list : "${key} = ${value}"]

    # map list with condition
    map_list_condition = [for key, value in var.map_list : "${key} = ${value * 2}"]



  }
}



