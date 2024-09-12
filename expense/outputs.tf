# use outputs.instances_info 
# outputs.instances_info == aws_instance.expense 

output "instances_info"{
    value = aws_instance.expense
}