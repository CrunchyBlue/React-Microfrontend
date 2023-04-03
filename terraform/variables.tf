variable "region" {
  type = string
  default = "ue2"
}

variable "environment" {
  type = string
  default = "p"
}

variable "app" {
  type = string
  default = "react-microfrontend"
}

variable "tags" {
  type = map(string)
  default = {
    Name        = "React Microfrontend"
    Environment = "Production"
  }
}