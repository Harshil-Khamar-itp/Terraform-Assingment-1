variable "vpcCidr" {
  default = "192.168.0.0/20"
}

variable "public_subnets" {
  default = ["192.168.1.0/24","192.168.2.0/24","192.168.3.0/24"]
}

variable "private_subnets" {
  default = ["192.168.4.0/24","192.168.5.0/24","192.168.6.0/24"]
}

variable "privateDbSubnetCidr" {
  default = ["192.168.7.0/24","192.168.8.0/24","192.168.9.0/24"]
}

variable "password" {
  
}

variable "userName" {
  
}
variable "ami" {
  default = "ami-005f9685cb30f234b"  
}

