resource "aws_instance" "terraform_instance" {
  ami           = "ami-01ccff0fc8b9448a6"
  instance_type = "t2.micro"
  key_name = "key-pem"

  tags = {
    Name = "terraform-instanace"
  }
}
