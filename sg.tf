
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Example security group"
  vpc_id      = aws_vpc.My_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }

  tags = {
    Name = "alb-sg"
  }
}
// Security Group 2 

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Example security group"
  vpc_id      = aws_vpc.My_vpc.id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    // cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
    security_groups = [aws_security_group.alb_sg.id] # Allow HTTP from ALB SG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }

  tags = {
    Name = "web-sg"
  }
}