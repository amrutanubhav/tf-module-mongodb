resource "aws_security_group" "allow_mongodb" {
  name        = "allow_${var.component}"
  description = "roboshop-${var.ENV}-mongodb-sg"

  ingress {
    description      = "alow docdb from local network"
    from_port        = 27017
    to_port          = 27017
    protocol         = "tcp"
    cidr_blocks      = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
    
  }

  ingress {
    description      = "alow docdb from default vpc network"
    from_port        = 27017
    to_port          = 27017
    protocol         = "tcp"
    cidr_blocks      = [data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-${var.ENV}-mongodb-sg"
  }
}