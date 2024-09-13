resource "aws_instance" "expense" {
  count = length(var.instance_names)

  ami                    = data.aws_ami.ami_info.id
  instance_type          = var.instance_names[count.index] == "mysql" ? "t3.small" : "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]
  # tags = {
  #     Name = var.instance_names[count.index]
  # }

  tags = {
    Name = var.instance_names[count.index]
  }
}



resource "aws_security_group" "allow_ssh_terraform" {
  name        = "allow_sshh"                          # becoz, allow_shh is already existed
  description = "Allow port number 22 for ssh access" # optional 

  # usually we allow everything in egress
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # -1 indicates everything 
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"         # -1 indicates everything 
    cidr_blocks      = ["0.0.0.0/0"] # allowing from everyone
    ipv6_cidr_blocks = ["::/0"]
  }

  # tags = {
  #     Name = "allow_sshh"
  # }

  tags = {
    Name = "allow_sshh"
  }
}

# if prod create t3.medium, otherwise create t3.micro 
resource "aws_instance" "terraform" {

    ami = data.aws_ami.ami_info.id
    instance_type = local.instance_type
    vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]
    tags = {
        Name = "terraform"
    }
}