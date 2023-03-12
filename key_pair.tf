resource "aws_key_pair" "ec2Key" {
    key_name = "ec2Key"
    public_key = file("ec2.pub")
}