provider "aws" {
  region  = var.aws_region
}

data "aws_vpc" "existing_vpc" {
  id = var.vpc_existente
}

data "aws_subnets" "vpc_subnets" {
  filter {
    name   = "vpc-id"  
    values = [data.aws_vpc.existing_vpc.id]
  }
}


resource "aws_security_group" "web_sg" {
  name        = "web_security_group"
  description = "Security group for web server"
  vpc_id      = data.aws_vpc.existing_vpc.id

  dynamic "ingress" {
    for_each = var.rules 
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.proto
      cidr_blocks = ingress.value.cidrs
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}


resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}

### -------------------------KEY PAR ---------------------------------------
resource "tls_private_key" "example_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
resource "aws_key_pair" "generated_key_pair" {
  key_name   = "my-terraform-key"
  public_key = tls_private_key.example_key.public_key_openssh
}
### -------------------------KEY PAR ---------------------------------------

resource "aws_instance" "lab_enviroment" {
  ami                    = "ami-06b21ccaeff8cd686"  
  instance_type          = var.instance_type
  subnet_id              = tolist(data.aws_subnets.vpc_subnets.ids)[1] 
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = aws_key_pair.generated_key_pair.key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  associate_public_ip_address = true
  tags = {
    Name = "lab_environment"
  }
}






/*
resource "aws_s3_bucket" "bucket-terraform" {
  bucket = "buckettatitestmameluco" 
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket-terraform.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_dynamodb_table" "terraform_locks" {
  name           = "terraform-state-locking"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}*/
