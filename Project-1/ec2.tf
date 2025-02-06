resource "aws_instance" "web" {
    ami = "ami-085ad6ae776d8f09c"  #update the ami_id with the latest one to avoid errors
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_a.id
    key_name = "jenkins"

    tags = {
        Name = "web-server"
    }
}