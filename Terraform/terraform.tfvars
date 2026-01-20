region       = "us-east-2"
project_name = "Trend-store"

vpc_cidr = "172.31.0.0/16"

public_subnet_cidrs  = ["172.31.32.0/20", "172.31.0.0/20"]
private_subnet_cidrs = ["", ""]

main_cidr     = "0.0.0.0/0"
instance_type = "t3.medium"
