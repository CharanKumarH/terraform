# 📦 Terraform AWS VPC Setup: EC2, Subnets & IAM Automation

A robust, modular Infrastructure-as-Code (IaC) solution using Terraform to provision AWS resources, including:

- Custom VPC with public and private subnets
- Dynamic EC2 instance deployment (using `for_each` with a configurable map)
- Automated IAM user creation and role-based policy assignment
- Clean, scalable, and reusable module structure

---

## ✅ Key Features

- 🔧 Customizable VPC and subnet architecture via [`terraform-aws-modules/vpc/aws`](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
- 🚀 Dynamic EC2 instance management using maps and `for_each`
- 👤 IAM users and role mapping driven by YAML configuration
- 🛡️ Granular IAM policy assignment per user
- 📂 Logical resource naming and organized outputs

---

## 🛠️ Technologies & Tools

- **Terraform**: v1.5 or newer (recommended)
- **AWS**: via the official `hashicorp/aws` provider
- **YAML**: for flexible IAM user/role configuration
- **Reusable Modules**: clean, DRY infrastructure code

---

## 📁 Project Structure
```
  . 
  ├── main.tf
  ├── variables.tf
  ├── outputs.tf
  ├── users.yaml
  ├── terraform.tfvars
  ├── .env
  └── README.md
```


---

## 🔐 AWS Credentials Setup

To authenticate Terraform with AWS, create a `.env` file in your project’s root directory:

```env
AWS_ACCESS_KEY_ID=your-access-key-id
AWS_SECRET_ACCESS_KEY=your-secret-access-key
