variable "region" {
  type = string
  default = "ue1"
}

variable "environment" {
  type = string
  default = "p"
}

variable "app" {
  type = string
  default = "react-microfrontend"
}

variable "domain" {
  type = string
  default = "example.com"
}

variable "tags" {
  type = map(string)
  default = {
    Application        = "React Microfrontend"
    Environment = "Production"
  }
}