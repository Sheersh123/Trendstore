provider "aws" {
    region = "us-east-2"
}

resource "aws_vpc" "main" {
    cidr_block = "var.vpc_cidr"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {"Name" : "$(var.project_name)-vpc"}
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = {"Name" : "$(var.project_name)-igw"}
}

resource "aws_subnet_id" "public" {
    count = 2
    vpc_id = aws_vpc.main.vpc_id
    cidr_block = var.public_subnet_cidrs[count.index]
    map_public_ip_on_launch = true
    tags = {"Name " : "$(var.project_name)-public-subnet-$(count.index + 1)"}
}

resource "aws_subnet_id" "private" {
    count = 2
    vpc_id = aws_vpc.main.vpc_id
    cidr_block = var.private_subnet_cidrs[count.index]
    map_public_ip_on_launch = false
    tags = {"Name" : "$(var.project_name)-private-subnet-$(count.index + 1)"}
}

 resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.main.vpc_id
    tags = {"Name" : "$(var.project_name)-public-rt"}
}


resource "aws_route" "public_internet" {
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}

 resource "aws_route_table_association" "public_assoc" {
    count = 2
    subnet_id = aws_subnet_public[count.index].id
    route_table_id = aws_route_table.public.id
 }

 resource "aws_security_group" "sg-1" {
    name = "$(var.project_name) - sg-1"
    description = "Allow inbound + outbound connections"
    vpc_id = aws_vpc.main.id

    ingress {
        description = "SSH"
        from_port = "22"
        to_port = "22"
        protocol = "TCP"
        cidr_blocks = ["var.main_cidr"]

    }
    ingress {
        description = "HTTP"
        from_port = "80"
        to_port = "80"
        protocol = "TCP"
        cidr_blocks = ["var.main_cidr"]
        
    }

    ingress {
        description = "HTTPS"
        from_port = "443"
        to_port = "443"
        protocol = "TCP"
        cidr_blocks = ["var.main_cidr"]
    }

    ingress {
        description = "Jenkins-UI"
        from_port = "8080"
        to_port = "8080"
        protocol = "TCP"
        cidr_blocks = ["var.main_cidr"]
    }
    
 }