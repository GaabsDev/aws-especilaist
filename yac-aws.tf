# Arquivo: main.tf

# Provedor da nuvem (exemplo: AWS)
provider "aws" {
  region = "us-west-2"
}

# Recurso do grupo de usuários
resource "aws_iam_group" "group" {
  name = "my-group"
}

# Recurso do usuário
resource "aws_iam_user" "user" {
  name = "my-user"
}

# Associação do usuário ao grupo
resource "aws_iam_user_group_membership" "membership" {
  user  = aws_iam_user.user.name
  groups = [aws_iam_group.group.name]
}

# Recurso do diretório
resource "aws_iam_group_policy" "policy" {
  name = "my-policy"
  group = aws_iam_group.group.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": [
        "arn:aws:s3:::my-bucket/*"
      ]
    }
  ]
}
EOF
}
