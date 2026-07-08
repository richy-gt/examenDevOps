output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "alb_dns_name" {
  description = "URL publica de la aplicacion (punto de entrada a internet)"
  value       = aws_lb.main.dns_name
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "rds_endpoint" {
  value = aws_db_instance.main.address
}

output "ecr_repository_urls" {
  value = {
    frontend  = aws_ecr_repository.frontend.repository_url
    ventas    = aws_ecr_repository.ventas.repository_url
    despachos = aws_ecr_repository.despachos.repository_url
  }
}

output "frontend_target_group_arn" {
  value = aws_lb_target_group.frontend.arn
}

output "security_group_ids" {
  value = {
    alb      = aws_security_group.alb.id
    frontend = aws_security_group.frontend.id
    backend  = aws_security_group.backend.id
    db       = aws_security_group.db.id
  }
}
