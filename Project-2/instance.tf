resource "aws_instance" "web" {
  ami             = "ami-04b4f1a9cf54c11d0"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public_a.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name        = "jenkins"
  tags = {
    Name = "web-instance"
  }
}

resource "aws_instance" "app" {
  ami             = "ami-04b4f1a9cf54c11d0"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public_a.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  key_name        = "jenkins"
  tags = {
    Name = "app-instance"
  }
}

resource "aws_instance" "db" {
  ami             = "ami-04b4f1a9cf54c11d0"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public_a.id
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  key_name        = "jenkins"
  tags = {
    Name = "db-instance"
  }
}

resource "aws_instance" "bastion" {
  ami             = "ami-04b4f1a9cf54c11d0"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public_a.id
  key_name        = "jenkins"
  tags = {
    Name = "bastion-host"
  }
}

