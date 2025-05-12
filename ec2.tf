resource "aws_instance" "vps" {
  ami                    = "ami-0c02fb55956c7d316" # Amazon Linux 2 (vérifiez pour votre région)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = aws_key_pair.deployer.key_name

  tags = {
    Name = "SecureVPS"
  }
}
