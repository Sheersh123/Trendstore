variable "region" {
  type    = string
  default = "us-east-2"
}

variable "project_name" {
  type    = string
  default = "Trend-store"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "172.31.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Two public subnet CIDRs"
  type        = list(string)
  default     = ["172.31.32.0/20", "172.31.0.0/20"]
}

variable "private_subnet_cidrs" {
  description = "Two private subnet CIDRs"
  type        = list(string)
  default     = ["", ""]
}

variable "main_cidr" {
  description = "CIDR allowed to access SSH/Jenkins (use your public IP/32 for security)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "instance_type" {
  description = "EC2 instance type for Jenkins"
  type        = string
  default     = "t3.medium"
}
