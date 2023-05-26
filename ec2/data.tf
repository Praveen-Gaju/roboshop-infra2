data "aws_caller_identity" "current" {}

data "aws_ami" "ami" {
  most_recent      = true
  #below image is used when we are executing roboshop with shell script
  #name_regex       = "Centos-8-DevOps-Practice"
  #owners           = ["973714476881"]
  name_regex        = "ansible-image"
  owners            = [data.aws_caller_identity.current.account_id]
}