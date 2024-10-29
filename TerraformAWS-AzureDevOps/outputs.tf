output "instance_ip" {
  value       = aws_instance.lab_enviroment.public_ip
  description = "Dirección IP pública de la instancia EC2"
}

output "private_key_pem" {
  value       = tls_private_key.example_key.private_key_pem
  description = "La clave privada generada para SSH"
  sensitive   = true
}