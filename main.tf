/**
 * # AWS EC2 Amazon Linux 2 with SSM
 *
 * This Terraform module creates an Amazon Linux 2 EC2 instance with AWS Systems Manager enabled.
 *
 *
 *
 */
resource "aws_instance" "main" {
  ami                         = data.aws_ssm_parameter.amazon_linux_2_latest_ami.value
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id

  iam_instance_profile   = aws_iam_instance_profile.ssm_instance_profile.name
  vpc_security_group_ids = var.vpc_security_group_ids

  user_data_base64 = local.user_data_linux_base64

  credit_specification {
    cpu_credits = var.unlimited_cpu_credits ? "unlimited" : "standard"
  }

  tags = local.default_tags
}
