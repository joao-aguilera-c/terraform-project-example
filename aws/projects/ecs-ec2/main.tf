provider "aws" {
  region = var.region
}
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = "ecs-asg-one"

  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = ["subnet-6b508b27", "subnet-4d433037", "subnet-2c717444"]

  initial_lifecycle_hooks = [
    {
      name                  = "ExampleStartupLifeCycleHook"
      default_result        = "CONTINUE"
      heartbeat_timeout     = 60
      lifecycle_transition  = "autoscaling:EC2_INSTANCE_LAUNCHING"
      notification_metadata = jsonencode({ "hello" = "world" })
    },
    {
      name                  = "ExampleTerminationLifeCycleHook"
      default_result        = "CONTINUE"
      heartbeat_timeout     = 180
      lifecycle_transition  = "autoscaling:EC2_INSTANCE_TERMINATING"
      notification_metadata = jsonencode({ "goodbye" = "world" })
    }
  ]

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  # Launch template
  launch_template_name        = "example-asg"
  launch_template_description = "Launch template example"
  update_default_version      = true

  image_id          = "ami-08333bccc35d71140"
  instance_type     = "t2.micro"
  ebs_optimized     = true
  enable_monitoring = true

  # IAM role & instance profile
  create_iam_instance_profile = false
  # iam_role_name               = "example-asg"
  # iam_role_path               = "/ec2/"
  # iam_role_description        = "IAM role example"
  # iam_role_tags = {
  #   CustomIamRole = "Yes"
  # }
  # iam_role_policies = {
  #   AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  # }

  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 20
        volume_type           = "gp2"
      }
    }
  ]

  capacity_reservation_specification = {
    capacity_reservation_preference = "open"
  }

  # cpu_options = {
  #   core_count       = 1
  #   threads_per_core = 1
  # }

  credit_specification = {
    cpu_credits = "standard"
  }

  # instance_market_options = {
  #   market_type = "spot"
  #   spot_options = {
  #     block_duration_minutes = 60
  #   }
  # }

  # metadata_options = {
  #   http_endpoint               = "enabled"
  #   http_tokens                 = "required"
  #   http_put_response_hop_limit = 32
  # }

  # network_interfaces = [
  #   {
  #     delete_on_termination = true
  #     description           = "eth0"
  #     device_index          = 0
  #     security_groups       = ["sg-12345678"]
  #   },
  #   {
  #     delete_on_termination = true
  #     description           = "eth1"
  #     device_index          = 1
  #     security_groups       = ["sg-12345678"]
  #   }
  # ]

  # placement = {
  #   availability_zone = "us-west-1b"
  # }

  tag_specifications = [
    {
      resource_type = "instance"
      tags          = { WhatAmI = "Instance" }
    },
    {
      resource_type = "volume"
      tags          = { WhatAmI = "Volume" }
    },
    {
      resource_type = "spot-instances-request"
      tags          = { WhatAmI = "SpotInstanceRequest" }
    }
  ]

  tags = {
    Environment = "dev"
    Project     = var.project_name
  }
}




module "ecs_cluster" {
  source = "terraform-aws-modules/ecs/aws//modules/cluster"

  cluster_name = "ecs-ec2"

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "/aws/ecs/aws-ec2"
      }
    }
  }

  autoscaling_capacity_providers = {
    one = {
      auto_scaling_group_arn         = module.asg.autoscaling_group_arn
      # managed_termination_protection = "ENABLED"

      managed_scaling = {
        maximum_scaling_step_size = 5
        minimum_scaling_step_size = 1
        status                    = "ENABLED"
        target_capacity           = 60
      }

      default_capacity_provider_strategy = {
        weight = 60
        base   = 20
      }
    }
  }

  tags = {
    Environment = "Development"
    Project     = var.project_name
  }
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"

  name = "test-alb"

  load_balancer_type = "application"

  vpc_id             = "vpc-c2a8baaa"
  subnets            = ["subnet-6b508b27", "subnet-4d433037", "subnet-2c717444"]
  # security_groups    = ["sg-edcd9784", "sg-edcd9785"]

  # access_logs = {
  #   bucket = "my-alb-logs"
  # }

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "ip"
      # targets = {
      #   my_target = {
      #     target_id = "i-0123456789abcdefg"
      #     port = 80
      #   }
      #   my_other_target = {
      #     target_id = "i-a1b2c3d4e5f6g7h8i"
      #     port = 8080
      #   }
      # }
    }
  ]

  # https_listeners = [
  #   {
  #     port               = 443
  #     protocol           = "HTTPS"
  #     certificate_arn    = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
  #     target_group_index = 0
  #   }
  # ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "Test"
  }
}

module "ecs_service" {
  source = "terraform-aws-modules/ecs/aws//modules/service"

  name        = "hello-world"
  cluster_arn = module.ecs_cluster.arn

  cpu    = 256
  memory = 512

  # Container definition(s)
  container_definitions = {
    hello-world = {
      cpu       = 256
      memory    = 512
      essential = true
      image     = "docker.io/_/httpd:latest"
      port_mappings = [
        {
          name          = "default"
          containerPort = 80
          protocol      = "tcp"
        }
      ]

      # Example image used requires access to write to root filesystem
      readonly_root_filesystem = false 

      enable_cloudwatch_logging = true
      # memory_reservation = 100
    }
  }

  service_connect_configuration = {
    # namespace = "example"
    service = {
      client_alias = {
        port     = 80
        dns_name = "hello-world"
      }
      port_name      = "default"
      discovery_name = "hello-world"
    }
  }

  load_balancer = {
    service = {
      target_group_arn = module.alb.target_group_arns[0]
      container_name   = "hello-world"
      container_port   = 80
    }
  }

  subnet_ids = ["subnet-6b508b27", "subnet-4d433037", "subnet-2c717444"]
  security_group_rules = {
    alb_ingress_3000 = {
      type                     = "ingress"
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      description              = "Service port"
      source_security_group_id = module.alb.security_group_id
    }
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}