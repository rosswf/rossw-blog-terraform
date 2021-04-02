output "ip_address" {
    value = aws_eip.server_ip.public_ip
}