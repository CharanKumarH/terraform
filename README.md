# 📦 Terraform AWS VPC Setup with EC2, Subnets, and IAM

A Terraform-based infrastructure-as-code (IaC) project to provision a complete AWS environment. This includes:

- Custom VPC with public and private subnets
- EC2 instance provisioning using `for_each` with a configurable map
- IAM user creation with role-based policy attachment
- Modular, scalable, and reusable Terraform code structure

---

## ✅ Features

- 🔧 Configurable VPC and subnet layout using `terraform-aws-modules/vpc/aws`
- 📦 Dynamic EC2 instance creation using maps and `for_each`
- 👤 IAM users with role mapping via YAML
- 🛡️ User-specific IAM policy attachment
- 📂 Clean outputs and logical resource naming

---

## 🚀 Technologies Used

- Terraform (v1.5+ recommended)
- AWS (via `hashicorp/aws` provider)
- YAML input for user configuration
- Reusable modules and dynamic expressions

---

## 📁 File Structure
.
├── main.tf
├── variables.tf
├── outputs.tf
├── users.yaml
├── terraform.tfvars
└── README.md
