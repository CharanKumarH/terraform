terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
}

locals {
  user_data = yamldecode(file("./users.yaml")).users
  user_role_pair = flatten([for user in local.user_data : [for role in user.roles : {
    # 
    username = user.username
    role     = role
  }]])
}

output "output" {
  value = {
    username =  local.user_data[*].username
    user_role_pair = local.user_role_pair
  }
}

# # create iam user
# resource "aws_iam_user" "user" {
#     count = length(local.user_data)
#     name  = local.user_data[count.index].username
#     tags = {
#         Name = local.user_data[count.index].username
#     }
# }

# create iam user
resource "aws_iam_user" "iam_user" {
  for_each = toset(local.user_data[*].username)
  name     = each.value


}

# password created for iam user
resource "aws_iam_user_login_profile" "user_profile" {
  for_each        = aws_iam_user.iam_user
  user            = each.value.name
  password_length = 12

  lifecycle {
    ignore_changes = [
      password,
      password_reset_required,
      pgp_key,
    ]
  }
}

# attach policy to iam user
resource "aws_iam_user_policy_attachment" "user_policy" {
  for_each = {for pair in local.user_role_pair : "${pair.username}-${pair.role} "=> pair}
  user     = aws_iam_user.iam_user[each.value.username].name
  policy_arn = "arn:aws:iam::aws:policy/${each.value.role}"
}
