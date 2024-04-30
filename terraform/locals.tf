locals {
    aws = {
        "381492249334" = {
            ami = "ami-04e1ec3aaf06b9060"
            ssh_cidrs = ["114.84.221.211/32", "101.228.215.157/32"]
            ebs_root_storage = 30
        }
    }
  
}

locals {
    config = lookup(local.aws, data.aws_caller_identity.current.account_id)
}