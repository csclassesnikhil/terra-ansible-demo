# ----------------------------
# Get latest Amazon Linux AMI
# ----------------------------

variable "key_name" {
description = "Existing EC2 key pair name"
}


data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# ----------------------------
# Get default VPC
# ----------------------------
data "aws_vpc" "default" {
  default = true
}

# ----------------------------
# Get a subnet from default VPC
# ----------------------------
data "aws_subnet" "default" {
  vpc_id = data.aws_vpc.default.id
}

# ----------------------------
# Create EC2 Instance
# ----------------------------
resource "aws_instance" "demo_ec2" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.default.id
  key_name      = var.key_name 

  tags = {
    Name = "terraform-demo-ec2"
  }
}
