variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_existente"{
  type    = string
  default = "vpc-02f34730285587610"
}



variable "target_subnet_id" {
  default = "subnet-01181704426697df9"  # Coloca aquí el ID de la subred que deseas encontrar
}





## Variables para tipo de instancia 
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}


## Variables para el bloque de puertos abiertos del security group solo para los de entrada
variable "rules" {
  description = "Ingress rules for the security group"
  type = list(object({
    port  = number
    proto = string
    cidrs = list(string)
  }))
  default = [
    { port = 80,  proto = "tcp", cidrs = ["0.0.0.0/0"] },
    { port = 443, proto = "tcp", cidrs = ["0.0.0.0/0"] },
    { port = 22,  proto = "tcp", cidrs = ["0.0.0.0/0"] }
  ]
}
