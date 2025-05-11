resource "aws_security_group" "ec2_sg" {
  name        = "groupe-ssh-projet"
  description = "Autorise uniquement SSH depuis une IP spécifique"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [41.82.181.220]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-SSH-Projet"
  }
}
