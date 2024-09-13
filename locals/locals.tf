locals {
    domain_name = "daws81s.fun"
    zone_id = "Z04257701WZI9339PFVWF"
    # count.index will not work in locals 
    instance_type = var.environment == "prod" ? "t3.medium" : "t3.micro"
}