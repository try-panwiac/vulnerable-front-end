provider "aws" {
  region     = "us-west-2"
}

resource "aws_instance" "example" {
  ami             = "encrypted_ami_id"
  instance_type   = "t2.micro"
  key_name        = "example_keypair"
  subnet_id       = "example_subnet_id"
  vpc_security_group_ids = ["example_security_group_id"]
  associate_public_ip_address = false

  iam_instance_profile {
    name = "example"
  }

  root_block_device {
    encrypted     = true
  }

  launch_template {
    id      = aws_launch_template.example.id
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  ebs_optimized = true
}





resource "aws_launch_template" "example" {
  name = "example"

  user_data = <<EOF
              #!/bin/bash
              echo "Hello, World!" > index.html
              nohup python -m SimpleHTTPServer 80 &
              export access_key = "AKIAIOSFODNN7EXAMAAA"
              export secret_key = "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"
              EOF

  root_block_device {
    volume_type = "gp2"
    volume_size = 10
    encrypted = false
  }

  ebs_block_device {
    device_name = "/dev/xvdf"
    volume_type = "gp2"
    volume_size = 10
    encrypted = true
  }

  iam_instance_profile {
    name = "example"
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  image_id = "encrypted_ami_id"
  instance_type = "t2.micro"
}
