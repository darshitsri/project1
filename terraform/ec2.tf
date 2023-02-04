resource "aws_instance" "terraform_instance" {
  ami           = "ami-01ccff0fc8b9448a6"
  instance_type = "t2.micro"
  key_name = "key-pem"

  tags = {
    Name = "terraform-instanace"
  }
}
output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.terraform_instance.public_ip
}
