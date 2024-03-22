resource "aws_iam_user" "this_iam" {
  name = "newone"
  path = "/"

  tags = {
    tag-key = "created_by_aaditya"
  }
}

resource "aws_iam_access_key" "this_iam_key" {
  user = aws_iam_user.this_iam.name
}

resource "aws_iam_group" "this_iam_group" {
  name = "new_group"
  path = "/"
}

resource "aws_iam_user_group_membership" "this_iam_add_user_to_group" {
  user = aws_iam_user.this_iam.name

  groups = [
    aws_iam_group.this_iam_group.name
  ]
}