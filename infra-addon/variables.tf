variable "aws_region" {
  default = "us-east-1"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_session_token" {}

# IDs de recursos que YA existen y fueron creados manualmente.
# Sacalos de la consola de AWS (ver instrucciones en el chat).
variable "vpc_id" {
  description = "ID de tu VPC actual (VPC -> Your VPCs)"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs de tus 2 subredes publicas actuales"
  type        = list(string)
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "frontend_sg_id" {
  description = "ID de tu Security Group frontend-sg actual"
  type        = string
}

variable "project_name" {
  default = "examendevops"
}
