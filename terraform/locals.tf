locals {
    aws = {
        "381492249334" = {
            ami = "ami-04e1ec3aaf06b9060"
        }
    }
  
    # Use string interpolation to construct the 'config' variable
    config = "local.aws.${var.AWS_ACCOUNT}"
}