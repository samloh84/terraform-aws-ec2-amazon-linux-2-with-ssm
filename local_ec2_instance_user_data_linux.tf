
locals {

  user_data_linux = {
    users = concat([
      "default"
      ], var.ec2_username != "" && var.ec2_username != null && var.ec2_password_hash != "" && var.ec2_password_hash != null ?

      [
        {
          name   = var.ec2_username
          passwd = var.ec2_password_hash
        }
      ] : []
    )
    packages = [
      "https://s3.${data.aws_region.current.name}.amazonaws.com/amazon-ssm-${data.aws_region.current.name}/latest/linux_amd64/amazon-ssm-agent.rpm",
      "https://s3.${data.aws_region.current.name}.amazonaws.com/amazoncloudwatch-agent-${data.aws_region.current.name}/centos/amd64/latest/amazon-cloudwatch-agent.rpm"
    ]

    runcmd = [
      "sudo systemctl enable amazon-ssm-agent",
      "sudo systemctl start amazon-ssm-agent",
      "sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/etc/amazon-cloudwatch-agent.json",
    ]

    write_files = [
      {
        content = local.cloudwatch_agent_config_linux_json
        path    = "/etc/amazon-cloudwatch-agent.json"
      }
    ]

  }

  user_data_linux_yaml   = "#cloud-config\n${yamlencode(local.user_data_linux)}"
  user_data_linux_base64 = base64encode(local.user_data_linux_yaml)

}
