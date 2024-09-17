resource "aws_instance" "terraform" {

    ami = "ami-09c813fb71547fc4f"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]
    tags = {
        Name = "terraform"
    }

    # in this case my laptop is local 
    provisioner "local-exec"{
        command = "echo ${self.private_ip} > private_ip.txt"
    }

    connection {
        type = "ssh"
        user = "ec2-user"
        password = "DevOps321"
        host = self.public_ip
    }

    # provisioners will execute at the time of creation 
    provisioner "remote-exec" {
        inline = [
            "sudo dnf install ansible -y",
            "sudo dnf install nginx -y",
            "sudo systemctl start nginx"
        ]
    }

    provisioner "remote-exec"{
        when = destroy 
        inline = [
            "sudo systemctl stop nginx",
        ]
    }
}

resource "aws_security_group" "allow_ssh_terraform"{
    name        = "allow_sshhhh"  # becoz, allow_shh is already existed
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

       ingress {    # ingress is like an inbound rules in AWS
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"   # -1 indicates everything 
        cidr_blocks      = ["0.0.0.0/0"]   # allowing from everyone
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "allow_sshhhh"
    }
}


