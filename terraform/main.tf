# goal :- to create a simple ec2 insatnce 
# key-pair
# region
# cnt
# instance type
# sg - ingress , egress
# ami (amazon image)

data "aws_ami" "my_ec2_ami"{
    most_recent = true

    filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
    filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
    owners = ["099720109477"] # Canonical
}

resource "aws_default_vpc" "my_vpc"{

}

resource "aws_security_group" "my_sg"{
    name = "my-ec2-terra-automate"
    description = "Security group for terra-auto-server"
    vpc_id = aws_default_vpc.my_vpc.id
    tags = {
    Name = "My-terra-auto-server-sg"
    }
}

resource "aws_vpc_security_group_ingress_rule" "my_ingress_rule_ssh"{
    security_group_id = aws_security_group.my_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 22
    ip_protocol = "tcp"
    to_port = 22

}

resource "aws_vpc_security_group_egress_rule" "my_egress_rule_ssh"{
    security_group_id = aws_security_group.my_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"  # semantically equivalent to all ports
}

resource "aws_key_pair" "my_key"{
    key_name = "shiv_terra_key_simple"
<<<<<<< Updated upstream
    public_key = file("${path.module}/keys/shiv_terra_key_simple.pub")
=======
    public_key = file("/home/ubuntu/Terraform-Ansible-Rev/terraform/prv-key/shiv_terra_key_simple.pub")
>>>>>>> Stashed changes
}

resource "aws_instance" "my_simple_terra_instance"{
    ami = data.aws_ami.my_ec2_ami.id
    count = var.server_count
    instance_type = var.aws_instance_type
    availability_zone      = var.aws_availability_zone
    key_name = aws_key_pair.my_key.key_name
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    //instance_state = "running"
    root_block_device {
    volume_type = "gp3"
    volume_size = 25
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags
    ]
  }
   tags = {
    Name = "Anshul-terra-auto-server-${count.index+1}"
  }
}
