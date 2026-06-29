# Create EC2 instances.
resource "aws_instance" "terraform" {

    # Create 4 EC2 instances.
    count = 4

    # AMI (Operating System Image) used to launch the EC2 instances.
    ami = "ami-0220d79f3f480ecf5"

    # EC2 instance size.
    instance_type = "t3.micro"

    # Attach the Security Group created below to each EC2 instance.
    vpc_security_group_ids = [aws_security_group.allow_all.id]

    # Add tags to the EC2 instances.
    tags = {

        # Name of each EC2 instance.
        # count.index picks the name from the instances list.
        Name = var.instances[count.index]

        # Custom tag to identify Terraform-created resources.
        Terraform = "true"
    }
}

# Create a Security Group.
resource "aws_security_group" "allow_all" {

  # Security Group name.
  name = "allow_all"

  # Outbound traffic rules.
  egress {

    # Start port.
    from_port = 0

    # End port.
    to_port = 0

    # -1 means allow all protocols (TCP, UDP, ICMP, etc.).
    protocol = "-1"

    # Allow outbound traffic to anywhere on the Internet.
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound traffic rules.
  ingress {

    # Start port.
    from_port = 0

    # End port.
    to_port = 0

    # -1 means allow all protocols.
    protocol = "-1"

    # Allow inbound traffic from anywhere on the Internet.
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Add tags to the Security Group.
  tags = {

    # Name displayed in the AWS Console.
    Name = "Xlient_Systems_Dev_SG"
  }
}