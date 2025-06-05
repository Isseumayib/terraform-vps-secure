resource "aws_security_group" "ec2_sg" {
  name        = "groupe-ssh-http-https-projet"
  description = "Autorise SSH depuis une IP spécifique, HTTP et HTTPS en accès public"
  vpc_id      = aws_vpc.main.id

  # SSH (port 22) uniquement depuis ton IP
  ingress {
    description = "SSH depuis une IP spécifique"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["41.83.106.139/32"]
  }

  # HTTP (port 80) depuis partout
  ingress {
    description = "HTTP public"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS (port 443) depuis partout
  ingress {
    description = "HTTPS public"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Autoriser tout le trafic sortant
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-SSH-HTTP-HTTPS-Projet"
  }
}
