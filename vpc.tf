resource "aws_vpc" "vm-vpc" {
  cidr_block = var.vm-vpc

  tags = {

    Name = "vm-vpc"
  }
}

resource "aws_subnet" "pubsn1" {
  count = length(var.PUBSN)
  vpc_id     = aws_vpc.vm-vpc.id
  cidr_block = element(var.PUBSN, count.index)
  availability_zone = element(var.avz, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "PUBSN_${count.index +1}"
  }

}

resource "aws_internet_gateway" "IGW" {
vpc_id = aws_vpc.vm-vpc.id

tags = {

Name = "IGW1"

}
}
resource "aws_route_table" "PUBRT" {
vpc_id = aws_vpc.vm-vpc.id
route {
  gateway_id = aws_internet_gateway.IGW.id
  cidr_block = "0.0.0.0/0"
}

tags = {
  Name = "PUBRT"
}
}

resource "aws_route_table_association" "PUBRTSNA"{
count = length(var.PUBSN)
subnet_id = element(aws_subnet.pubsn1.*.id, count.index)
route_table_id = aws_route_table.PUBRT.id

}

resource "aws_eip" "lb" {
  domain   = "vpc"

  tags = {
   
   Name = "vpc-igw"

  }

}
resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.pubsn1[0].id

  tags = {
    Name = "vpc-NAT"
  }

}

resource "aws_subnet" "pvtsn1" {
  count = length(var.PVTSN)
  vpc_id     = aws_vpc.vm-vpc.id
  cidr_block = element(var.PVTSN, count.index)

  tags = {
    Name = "PVTSN_${count.index +1}"
  }

}

resource "aws_route_table" "PVTRT" {
vpc_id = aws_vpc.vm-vpc.id
route {
  nat_gateway_id = aws_nat_gateway.example.id
  cidr_block = "0.0.0.0/0"
}

tags = {
  Name = "PVTRT"
}
}

resource "aws_route_table_association" "PVTRTSNA"{
count = length(var.PVTSN)
subnet_id = element(aws_subnet.pvtsn1.*.id, count.index)
route_table_id = aws_route_table.PVTRT.id

}