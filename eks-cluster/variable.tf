variable "vpc-cidr" {
  description = "The cidr of VPC"
  type        = string

}

variable "subnet-cidr" {
  description = "Subnet CIDR"
  type        = list(string)
}


variable "private-subnet-cidr" {
  description = "Subnet CIDR"
  type        = list(string)
}
