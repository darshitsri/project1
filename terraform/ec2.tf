resource "aws_instance" "terraform_instance" {
  ami           = "ami-06984ea821ac0a879"
  instance_type = "t2.micro"
  key_name = "key-pem"

  tags = {
    Name = "terraform-instanace"
  }
}
