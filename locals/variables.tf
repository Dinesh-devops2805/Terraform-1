variable "instance_names" {
  type    = list(string)
  default = ["mysql", "backend", "frontend"]
}

# variable "domain_name" {
#   default = "daws81s.fun"
# }

# variable "zone_id" {
#   default = "Z04257701WZI9339PFVWF"
# }

variable "environment"{
  default = "prod"
}