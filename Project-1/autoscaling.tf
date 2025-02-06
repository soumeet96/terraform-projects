resource "aws_launch_template" "web" {
    name = "web-lc"
    image_id = "ami-085ad6ae776d8f09c"
    instance_type = "t2.micro"
    key_name = "jenkins"  #check your own pem file

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "web" {
    launch_template {
        id      = aws_launch_template.web.id
        version = "$Latest"
    }
    min_size = 1
    max_size = 2
    desired_capacity = 2
    vpc_zone_identifier = [aws_subnet.public_a.id, aws_subnet.public_b.id]

    tag {
        key = "Name"
        value = "web-instance"
        propagate_at_launch = true
    }
}