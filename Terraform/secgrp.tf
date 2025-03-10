resource "aws_security_group" "ecssg" {
  vpc_id = aws_vpc.ecsvpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  tags = {
    Name = "ECS-Fargate-SG"
  }
}