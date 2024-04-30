data "aws_vpc" "default" {
    default = true
}

data "aws_subnets" "all" {
    filter {
        name   = "vpc-id"
        values = [data.aws_vpc.default.id]
    }
}

data "aws_caller_identity" "current" {}

output "account_id" {
    value = data.aws_caller_identity.current.account_id
}

output "vpc_id" {
    value = data.aws_vpc.default.id
}

output "subnet_ids" {
    value = data.aws_subnets.all.ids
}