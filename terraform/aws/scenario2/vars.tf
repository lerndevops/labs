variable "aws_region" {
  description = "Region for the VPC"
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  default     = "10.0.2.0/24"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default     = "ami-28e07e50"
}

variable "key_path" {
  description = "SSH Public Key path"
  default     = "public_key"
}
