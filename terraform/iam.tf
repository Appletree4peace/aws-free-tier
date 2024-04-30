resource "aws_iam_role" "ssm_role_for_instances" {
    name = "SSMRoleForInstances"

    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Action": "sts:AssumeRole",
    "Principal": {"Service": "ec2.amazonaws.com"},
    "Effect": "Allow",
    "Sid": ""
  }]
}
EOF
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
    name = "SSMInstanceProfile"
    role = aws_iam_role.ssm_role_for_instances.name
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
    role       = aws_iam_role.ssm_role_for_instances.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ssm_patch_association" {
  role       = aws_iam_role.ssm_role_for_instances.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
}

resource "aws_iam_policy" "execution_policy" {
    name        = "ExecutionPolicy"
    description = "A custom inline policy for SSM Role"
    policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:PassRole",
        "sts:AssumeRole",
        "*"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "ExecutionPolicyPermissions"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "execution_policy_attachment" {
    role       = aws_iam_role.ssm_role_for_instances.name
    policy_arn = aws_iam_policy.execution_policy.arn
}