resource "aws_security_group" "public_sg" {
  name        = "public_sg"
  description = "Limit inbound traffic, allow all outbound traffic."
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Pingable from anywhere."
    protocol    = "icmp"
    from_port   = -1
    to_port     = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow inbound HTTP traffic."
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow inbound SSH traffic."
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic."
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.namespace}-public-sg"
    Namespace = var.namespace
  }

  depends_on = [
    aws_vpc.vpc
  ]

}