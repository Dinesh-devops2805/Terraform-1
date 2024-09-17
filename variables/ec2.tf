resource "aws_instance" "terraform" {

    ami = var.ami_id   # ami left side and right side no need to be same 
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]
    tags = var.tags
}


resource "aws_security_group" "allow_ssh_terraform"{
    name        = var.sg_name  # becoz, allow_shh is already existed
    description = var.sg_description # optional 
    
# usually we allow everything in egress
#egress block 
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1" # -1 indicates everything 
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    ingress {
        from_port        = var.from_port
        to_port          = var.to_port
        protocol         = var.protocol  # -1 indicates everything 
        cidr_blocks      = var.ingress_cidr  # allowing from everyone
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = var.tags
}
