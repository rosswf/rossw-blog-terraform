resource "aws_instance" "blog_web_server" {
    ami             = "ami-096cb92bb3580c759"
    instance_type   = var.type
    key_name        = var.key_name
    vpc_security_group_ids = [aws_security_group.blog_security_group.id]

    tags = {
        Name = "Blog Web Server"
    } 
}

resource "aws_key_pair" "blog_key" {
    key_name        = var.key_name
    public_key      = var.public_key
}

resource "aws_security_group" "blog_security_group" {
    name            = "Blog Web Server"
    description     = "Allow web and local SSH"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${var.my_public_ip}/32"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_eip" "server_ip" {
    vpc = true
    instance = aws_instance.blog_web_server.id
}

resource "cloudflare_record" "blog_root" {
    zone_id     = var.zone_id
    name        = "@"
    value       = aws_eip.server_ip.public_ip
    type        = "A"
    ttl         = 1
    proxied     = true

    depends_on = [
        aws_eip.server_ip,
    ]
}

resource "cloudflare_record" "blog_www" {
    zone_id     = var.zone_id
    name        = "www"
    value       = aws_eip.server_ip.public_ip
    type        = "A"
    ttl         = 1
    proxied     = true

    depends_on = [
        aws_eip.server_ip,
    ]
}