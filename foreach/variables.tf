variable "instances"{
    type  = map 
    default = {
        mysql = "t3.small"
        backend = "t3.micro"
        frontend = "t3.micro"
    }
}

variable "domain_name"{
    default = "daws81s.fun"
}

variable "zone_id"{
    default = "Z039668017X5URB2EF8XU"
}