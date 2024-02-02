variable "aws_region" {
  type        = string
  description = "value of the AWS region"
  default     = "eu-north-1"
}

variable "aws_machine_type" {
  type        = string
  description = "value of the AWS machine type"
  default     = "t3.micro"
}


variable "aws_ami" {
  description = "AMI ID for the AWS instance"
  type        = string
  default     = "ami-0014ce3e52359afbd"
}
