
resource "aws_instance" "vm12" {

    count = 1
    ami           = var.vm-ami
    instance_type = var.vm-type
    key_name      = var.vm-key
    subnet_id = aws_subnet.pvtsn1[0].id


  tags = {

    Name = "server1"
  }

} 

#####################JUMPSERVER###############

resource "aws_instance" "vm13" {

    count = 1
    ami           = var.vm-ami
    instance_type = var.vm-type
    key_name      = var.vm-key
    subnet_id = aws_subnet.pubsn1[0].id


  tags = {

    Name = "jumpserver1"
  }

}