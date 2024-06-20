variable "vm-ami" {
  default = "ami-033fabdd332044f06"

}

variable "vm-type" {
  default = "t2.micro"

}

variable "vm-key" {
  default = "aws"

}

variable "vm-vpc" {
  default = "192.168.0.0/24"

}

variable "PUBSN" {
    type = list(string)
    default = ["192.168.0.0/26","192.168.0.64/26"]
  
}

variable "avz" {
    type = list(string)
    default = ["us-east-2a","us-east-2b"]
  
}

variable "PVTSN" {
    type = list(string)
    default = ["192.168.0.128/26","192.168.0.192/26"]
  
}




