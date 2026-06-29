# Define a variable named "instances".
variable "instances" {

    # Default value of the variable.
    # This is a list of EC2 instance names.
    default = [
        "mongodb",
        "Redis",
        "mysql",
        "rabbitmq"
    ]
}

# Define a variable named "zone_id".
variable "zone_id" {

    # Route 53 Hosted Zone ID.
    # Terraform uses this ID to know where to create DNS records.
    default = "Z02096332LDFNHQKND39S"
}

# Define a variable named "domain_name".
variable "domain_name" {

    # Domain name used when creating Route 53 DNS records.
    # Example:
    # mongodb.srinivasak.online
    # mysql.srinivasak.online
    default = "srinivasak.online"
}

