resource "aws_vpc" "custom_vpc" {
    cidr_block = "10.1.0.0/16"

    tags = {
        Name = "practice-eks-vpc-dev"
    }
}

resource "aws_subnet" "public_subnet1" {
    vpc_id = aws_vpc.custom_vpc.id
    cidr_block = "10.1.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
        Name = "public-subnet-dev-1"
    }
}

resource "aws_subnet" "public_subnet2" {
    vpc_id = aws_vpc.custom_vpc.id
    cidr_block = "10.1.2.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true

    tags = {
        Name = "public-subnet-dev-2"
    }
}

resource "aws_subnet" "public_subnet3" {
    vpc_id = aws_vpc.custom_vpc.id
    cidr_block = "10.1.3.0/24"
    availability_zone = "us-east-1c"
    map_public_ip_on_launch = true

    tags = {
        Name = "public-subnet-dev-3"
    }
}

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.custom_vpc.id

    tags = {
        Name = "practice-eks-igw-dev"
    }
}

resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.custom_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }

    tags = {
        Name = "practice-eks-public-rt-dev"
    }
}

resource "aws_route_table_association" "a" {
    subnet_id = aws_subnet.public_subnet1.id
    route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "b" {
    subnet_id = aws_subnet.public_subnet2.id
    route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "c" {
    subnet_id = aws_subnet.public_subnet3.id
    route_table_id = aws_route_table.rt.id
}

output "subnet_ids" {
  value = [
    aws_subnet.public_subnet1.id,
    aws_subnet.public_subnet2.id,
    aws_subnet.public_subnet3.id
  ]
}
