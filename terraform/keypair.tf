resource "aws_key_pair" "example" {
    key_name   = "vm"
    public_key = file("/home/appletree/.ssh/id_rsa.pub")
}