resource "aws_instance" "freetier" {
    ami           = local.config.ami
    instance_type = "t2.micro"
    key_name = aws_key_pair.vm.key_name
    vpc_security_group_ids = [aws_security_group.free_tier.id]
  
    subnet_id = data.aws_subnets.all.ids[0]

    iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name
  
#    # Example of passing user data to run a script on instance startup
#    user_data = <<-EOF
#                #!/bin/bash
#                echo "Hello, World" > index.html
#                nohup busybox httpd -f -p 8080 &
#                EOF
#  

    ebs_block_device {
        device_name = "/dev/xvda"
        volume_size = local.config.ebs_root_storage
        volume_type = "gp3"
    }

    tags = {
        Name = "vm-freetier"
    }
}

output "instance_public_ip" {
    value = aws_instance.freetier.public_ip
}