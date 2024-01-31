resource "aws_instance" "dev-machine" {
  ami           = var.aws_ami
  instance_type = var.aws_machine_type
  tags = {
    Name = "dev-machine"
  }
}
