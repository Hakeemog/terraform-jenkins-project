# Declare the data source
data "aws_availability_zones" "eks-terraform" {
  state = "available"
}