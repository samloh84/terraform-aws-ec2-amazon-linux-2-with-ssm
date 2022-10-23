locals {

  cloudwatch_agent_config_linux = {
    "agent" = {
      "region"  = data.aws_region.current.name
      "logfile" = "/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log"
    }
    "logs" : {
      "logs_collected" = {
        "files" = {
          "collect_list" = [
            {
              "file_path"       = "/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log"
              "log_group_name"  = var.cloudwatch_log_group_ec2_logs
              "log_stream_name" = "{instance_id}_cloudwatch-agent"
              "timezone"        = "Local"
            },
            {
              "file_path"       = "/var/log/audit/audit.log"
              "log_group_name"  = var.cloudwatch_log_group_ec2_logs
              "log_stream_name" = "{instance_id}_audit"
              "timezone"        = "Local"
            },
            {
              "file_path"       = "/var/log/messages"
              "log_group_name"  = var.cloudwatch_log_group_ec2_logs
              "log_stream_name" = "{instance_id}_messages"
              "timezone"        = "Local"
            },
            {
              "file_path"       = "/var/log/secure"
              "log_group_name"  = var.cloudwatch_log_group_ec2_logs
              "log_stream_name" = "{instance_id}_secure"
              "timezone"        = "Local"
            },
            {
              "file_path"       = "/var/log/faillog"
              "log_group_name"  = var.cloudwatch_log_group_ec2_logs
              "log_stream_name" = "{instance_id}_faillog"
              "timezone"        = "Local"
            },
            {
              "file_path"       = "/var/log/cron"
              "log_group_name"  = var.cloudwatch_log_group_ec2_logs
              "log_stream_name" = "{instance_id}_cron"
              "timezone"        = "Local"
            },
            {
              "file_path"       = "/var/log/yum.log"
              "log_group_name"  = var.cloudwatch_log_group_ec2_logs
              "log_stream_name" = "{instance_id}_yum"
              "timezone"        = "Local"
            },
            {
              "file_path"       = "/var/log/sudo.log"
              "log_group_name"  = var.cloudwatch_log_group_ec2_logs
              "log_stream_name" = "{instance_id}_sudo"
              "timezone"        = "Local"
            }
          ]
        }
      }
    }
  }

  cloudwatch_agent_config_linux_json = jsonencode(local.cloudwatch_agent_config_linux)
}
