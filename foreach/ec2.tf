resource "aws_instance" "expense" {

    for_each = var.instances  # this variable is map 
    # for each will give us a special variable with name each 
    ami = "ami-09c813fb71547fc4f"  # this AMI ID may change over the time 
    instance_type = each.value
    vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]
    tags = {
        Name = each.key 
    }
}

resource "aws_security_group" "allow_ssh_terraform"{
    name        = "allow_sshh"  # becoz, allow_shh is already existed
    description = "Allow port number 22 for ssh" # optional 
    
# usually we allow everything in egress
    #block    # egress is just lika an outbound rules in AWS
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1" # -1 indicates everything 
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    ingress {    # ingress is like an inbound rules in AWS
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"   # -1 indicates everything 
        cidr_blocks      = ["0.0.0.0/0"]   # allowing from everyone
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "allow_sshh"
    }
}


