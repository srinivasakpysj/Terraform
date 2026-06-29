resource "aws_instance" "terraform" {
    ami = "ami-0220d79f3f480ecf5"
    instance_type = var.Environment == "dev" ? "t3.micro" : "t3.medium"
    vpc_security_group_ids = [aws_security_group.allow_all.id]
    tags = {
        Name = "terraform-1"
        Terraform = "true"
    }
}

resource "aws_security_group" "allow_all" {
  name = "allow_all"

  egress {
    from_port        = 0 # from port to 0 to port 0 means all ports
    to_port          = 0
    protocol         = "-1" # -1 means all protocols 
    cidr_blocks      = ["0.0.0.0/0"] # internet
  }

  ingress {
    from_port        = 0 # from port to 0 to port 0 means all ports
    to_port          = 0
    protocol         = "-1" # -1 means all protocols 
    cidr_blocks      = ["0.0.0.0/0"] # internet
  }
  tags  = {
    Name = "Xlient_Systems_Dev_SG"
  }
}
