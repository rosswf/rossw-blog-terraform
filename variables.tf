variable "type" {
    type = string
    default = "t2.micro"
}

variable "region" {
    type = string
    default = "eu-west-2"
}

variable "number" {
    type = string
    default = "1"
}

variable "key_name" {
    type = string
}

variable "public_key" {
    type = string
}

variable "zone_id" {
    type = string
}