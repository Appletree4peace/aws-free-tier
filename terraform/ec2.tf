

#resource "aws_instance" "freetier" {
#    ami           = local.config.ami
#    instance_type = "t2.micro"
#    key_name = aws_key_pair.vm.key_name
#    # Replace with the correct security group ID for your AWS environment
#    vpc_security_group_ids = ["sg-0123456789abcdef0"]
#  
#    # Replace with the correct subnet ID for your AWS environment
#    subnet_id = "subnet-0123456789abcdef0"
#  
#    # Example of passing user data to run a script on instance startup
#    user_data = <<-EOF
#                #!/bin/bash
#                echo "Hello, World" > index.html
#                nohup busybox httpd -f -p 8080 &
#                EOF
#  
#    tags = {
#        Name = "example-instance"
#    }
#}
#
#output "instance_public_ip" {
#    value = aws_instance.example.public_ip
#}