resource "aws_instance" "terraform" {

    ami = "ami-09c813fb71547fc4f"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]
    tags = {
        Name = "terraform"
    }
}

resource "aws_security_group" "allow_ssh_terraform"{
    name        = "dynamic_demo"  # becoz, allow_shh is already existed
    description = "Allow port numbers" # optional 
    
# usually we allow everything in egress
    #block    # egress is just lika an outbound rules in AWS
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1" # -1 indicates everything 
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    # terraform will give us a variable with block name 
    dynamic "ingress" {    # ingress is like an inbound rules in AWS
        for_each = var.ingress_rules
        content {
            from_port        = ingress.value["from_port"]
            to_port          = ingress.value["to_port"]
            protocol         = ingress.value["protocol"]  # -1 indicates everything 
            cidr_blocks      = ingress.value.cidr_blocks   # allowing from everyone
            # cidr_blocks      = ingress.value["cidr_blocks"] 
        }
    }

    tags = {
        Name = "allow_sshh"
    }
}


