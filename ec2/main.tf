#aws ec2 instance
resource "aws_instance" "ec2" {
  ami                     = data.aws_ami.ami.image_id
  instance_type           = var.instance_type
  iam_instance_profile    = "${var.env}-${var.component}-role"
  vpc_security_group_ids  = [aws_security_group.sg.id]
  tags = {
    Name      = var.component
    Monitor   = var.monitor ? "yes" : "no"
  }
}

resource "null_resource" "provisioner" {
  depends_on = [aws_route53_record.record]
  provisioner "remote-exec" {
    connection {
      host      = aws_instance.ec2.public_ip
      user      = "centos"
      password  = "DevOps321"
    }

    inline = [
      #below commands are used to execute using shell script
#      "git clone https://github.com/Praveen-Gaju/roboshop-shell.git",
#      "cd roboshop-shell",
#      "sudo bash ${var.component}.sh ${var.password}"
      #below code is used to execute script using ansible
      "ansible-pull -i localhost, -U https://github.com/Praveen-Gaju/roboshop-ansible.git roboshop.yml -e role_name=${var.component} -e env=${var.env}"
    ]
  }
}

#security group
resource "aws_security_group" "sg" {
  name        = "${var.component}-${var.env}-sg"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "ALL"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.component}-${var.env}-sg"
  }
}

#route53 records
resource "aws_route53_record" "record" {
  zone_id = "Z10378632KDOC11M5RXOI"
  name    = "${var.component}-${var.env}.devopspract.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.ec2.private_ip]
}

resource "aws_iam_policy" "ssm-policy" {
  name        = "${var.env}-${var.component}"
  path        = "/"
  description = "${var.env}-${var.component}"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "ssm:GetParameterHistory",
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        "Resource": "arn:aws:ssm:us-east-1:699776063346:parameter/${var.env}.${var.component}*"
      },
      {
        "Sid": "VisualEditor1",
        "Effect": "Allow",
        "Action": "ssm:DescribeParameters",
        "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_role" "ssm-role" {
  name = "${var.env}-${var.component}-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "profile" {
  name = "${var.env}-${var.component}-role"
  role = aws_iam_role.ssm-role.name
}

resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = aws_iam_role.ssm-role.name
  policy_arn = aws_iam_policy.ssm-policy.arn
}