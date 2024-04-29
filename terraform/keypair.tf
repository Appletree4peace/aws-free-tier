resource "aws_key_pair" "vm" {
    key_name   = "vm"
    public_key = file("/home/appletree/.ssh/id_rsa.pub")
}