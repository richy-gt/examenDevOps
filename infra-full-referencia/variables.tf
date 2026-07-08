variable "aws_region" {
  description = "Region de AWS (AWS Academy usa normalmente us-east-1)"
  type        = string
  default     = "us-east-1"
}

variable "aws_access_key" {
  description = "Access key temporal entregada por AWS Academy (AWS Details)"
  type        = string
}

variable "aws_secret_key" {
  description = "Secret key temporal entregada por AWS Academy (AWS Details)"
  type        = string
}

variable "aws_session_token" {
  description = "Session token temporal entregado por AWS Academy (AWS Details)"
  type        = string
}

variable "lab_role_arn" {
  description = "ARN del rol LabRole ya existente en la cuenta de AWS Academy. No se pueden crear roles/policies nuevos en este entorno, por lo que se reutiliza este rol para ejecucion y tareas de ECS."
  type        = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "db_username" {
  type      = string
  default   = "db_user"
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "project_name" {
  type    = string
  default = "examendevops"
}
