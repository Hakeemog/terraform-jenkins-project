terraform {
  backend "s3" {
    bucket = "pro-jenkins-bucket"
    key    = "eks/terraform"
    region = "us-east-2"
  }
}

