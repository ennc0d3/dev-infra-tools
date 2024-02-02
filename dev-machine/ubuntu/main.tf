

resource "aws_key_pair" "dev-machine" {
  key_name   = "dev-machine"
  public_key = file("~/.ssh/id_rsa.pub")
}


resource "aws_vpc" "dev-machine" {
  cidr_block = "172.0.0.0/16"
  tags = {
    Name = "dev-machine"
  }
}

resource "aws_subnet" "dev-machine" {
  vpc_id     = aws_vpc.dev-machine.id
  cidr_block = "172.0.0.0/24"
  tags = {
    Name = "dev-machine"
  }
}

resource "aws_internet_gateway" "dev-machine" {
  vpc_id = aws_vpc.dev-machine.id
  tags = {
    Name = "dev-machine"
  }
}

resource "aws_route_table" "dev-machine" {
  vpc_id = aws_vpc.dev-machine.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-machine.id
  }
  tags = {
    Name = "dev-machine"
  }
}

resource "aws_route_table_association" "dev-machine" {
  subnet_id      = aws_subnet.dev-machine.id
  route_table_id = aws_route_table.dev-machine.id
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
