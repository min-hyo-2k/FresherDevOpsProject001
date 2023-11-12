variable "region" {
  type = string
  default = "ap-southeast-1"
}

variable "ami" {
  type = string
  # Amazon Linux 2023 AMI (64-bit (x86))
  default = "ami-05caa5aa0186b660f"
}

variable "ec2_instance_type" {
  type = string
  default = "t2.micro"
}

variable "public_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDQF5iNaBM8LNNl3PHVYok7Io8G2SKdVviIvv6pWXZ14td2hCGqmm04tO0Z6OJJNssQtBsCm3ql5yD7KjvMzTmXDC5w7mFqFxiRrZsMQw1bpiDPjsQa1+O6R/wLBULzVSl/4DsxtaVKPILHRzSjZvxmyJ6oPbyFuV5SE4sb499CRsyq2IQSAuqXW4l+U06m5+r6rrRRiOTIiFPuHu5N0fci4+dwi2CSi8An9S6nHHsS4mcJd4IW83u3iuYrnWhEP6LwfRs7c6+wVhtY+KFBYa+7CZor7GpT0BiVGZRe8WzjxfBW9tfJSLUfN6lQDBWuQJP4BPjzW8sXGaFD/bljCJwmEwN1uAyY1JDzCvPjKeDZSiJrbE4pUXCnoOzSv38pokODJt/1AQ2nHZuNRDHUh4EmwaYW3Tt72+p2c/AWkUDbFqTbIjVQwyBYm7WvgGsB9VSN2g/2Mx4p4W4zkSjdVGyIIBweb7kMGuoQrh3BBSJqfEY/J+J7ylpg4e+EjbY6JL0= hieutm2712@MinHyo2k"
}