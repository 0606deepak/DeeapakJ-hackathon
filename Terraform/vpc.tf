resource "aws_vpc" "ecsvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "ECS-Fargate-VPC"
  }
}

resource "aws_subnet" "ecssubnet1" {
  vpc_id            = aws_vpc.ecsvpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "ECS-Fargate-Subnet-1"
  }
}

resource "aws_subnet" "ecssubnet2" {
  vpc_id            = aws_vpc.ecsvpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "ECS-Fargate-Subnet-2"
  }
}