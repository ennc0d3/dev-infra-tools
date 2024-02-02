

resource "aws_key_pair" "dev-machine" {
  key_name   = "dev-machine"
  public_key = file("~/.ssh/id_rsa.pub")
}


resource "aws_security_group" "dev-machine" {
  name        = "dev-machine"
  description = "Allow SSH inbound traffic"
  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "dev-machine"
  }
}
resource "aws_instance" "dev-machine" {
  ami             = var.aws_ami
  instance_type   = var.aws_machine_type
  security_groups = [aws_security_group.dev-machine.name]
  tags = {
    Name = "dev-machine"
  }
  key_name = aws_key_pair.dev-machine.key_name
}
