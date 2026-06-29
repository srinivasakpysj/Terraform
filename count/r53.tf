# --------------------------------------------------------------------
# Resource Type  : aws_route53_record
# Resource Name  : roboshop
# Purpose        : Creates Route 53 DNS A records for EC2 instances.
# --------------------------------------------------------------------
resource "aws_route53_record" "roboshop" {

  # 'count' is a Terraform meta-argument.
  # It tells Terraform how many copies of this resource to create.
  #
  # Since count = 4, Terraform creates four Route 53 records.
  #
  # Terraform automatically assigns:
  # count.index = 0
  # count.index = 1
  # count.index = 2
  # count.index = 3
  count = 4

  # Route 53 Hosted Zone ID.
  #
  # This tells AWS where the DNS records should be created.
  #
  # Example:
  # zone_id = "Z0123456789ABCDEFG"
  #
  # The value comes from variables.tf or terraform.tfvars.
  zone_id = var.zone_id

  # DNS Record Name.
  #
  # String interpolation combines:
  #
  # var.instances[count.index]
  # with
  # var.domain_name
  #
  # Example:
  #
  # var.instances = [
  #   "mongodb",
  #   "mysql",
  #   "redis",
  #   "rabbitmq"
  # ]
  #
  # var.domain_name = "example.com"
  #
  # Terraform creates:
  #
  # mongodb.example.com
  # mysql.example.com
  # redis.example.com
  # rabbitmq.example.com
  name = "${var.instances[count.index]}.${var.domain_name}"

  # Route 53 Record Type.
  #
  # A = IPv4 Address
  # AAAA = IPv6 Address
  # CNAME = Alias to another hostname
  # MX = Mail Server
  # TXT = Text Record
  type = "A"

  # TTL = Time To Live.
  #
  # DNS servers cache this record for 3 seconds.
  # After 3 seconds they ask Route 53 again for the latest value.
  ttl = 3

  # The IP address assigned to this DNS record.
  #
  # aws_instance.terraform
  # refers to an EC2 resource that was also created using count.
  #
  # Example:
  #
  # resource "aws_instance" "terraform" {
  #   count = 4
  # }
  #
  # Terraform matches the indexes:
  #
  # count.index = 0
  # aws_instance.terraform[0]
  #
  # count.index = 1
  # aws_instance.terraform[1]
  #
  # count.index = 2
  # aws_instance.terraform[2]
  #
  # count.index = 3
  # aws_instance.terraform[3]
  #
  # private_ip returns the EC2 instance's private IPv4 address.
  #
  # Example:
  #
  # mongodb.example.com  -> 172.31.20.10
  # mysql.example.com    -> 172.31.20.11
  # redis.example.com    -> 172.31.20.12
  # rabbitmq.example.com -> 172.31.20.13
  #
  # records expects a LIST, so the IP is enclosed in [].
  records = [aws_instance.terraform[count.index].private_ip]

  # If a DNS record with the same name already exists,
  # Terraform will overwrite it instead of throwing an error.
  #
  # true  -> Replace existing record.
  # false -> Fail if the record already exists.
  allow_overwrite = true
}

