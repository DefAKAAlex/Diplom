# Network outputs
output "vpc_id" {
  value       = yandex_vpc_network.diplom.id
  description = "VPC ID"
}

output "subnet_public_a" {
  value       = yandex_vpc_subnet.public_a.id
  description = "Public subnet A ID"
}

output "subnet_public_b" {
  value       = yandex_vpc_subnet.public_b.id
  description = "Public subnet B ID"
}

output "subnet_private_a" {
  value       = yandex_vpc_subnet.private_a.id
  description = "Private subnet A ID"
}

output "subnet_private_b" {
  value       = yandex_vpc_subnet.private_b.id
  description = "Private subnet B ID"
}

output "nat_gateway_id" {
  value       = yandex_vpc_gateway.nat.id
  description = "NAT Gateway ID"
}

# Security Group outputs
output "bastion_sg_id" {
  value       = yandex_vpc_security_group.bastion.id
  description = "Bastion Security Group ID"
}

output "web_sg_id" {
  value       = yandex_vpc_security_group.web.id
  description = "Web Security Group ID"
}

output "zabbix_sg_id" {
  value       = yandex_vpc_security_group.zabbix.id
  description = "Zabbix Security Group ID"
}

output "elasticsearch_sg_id" {
  value       = yandex_vpc_security_group.elasticsearch.id
  description = "Elasticsearch Security Group ID"
}

output "kibana_sg_id" {
  value       = yandex_vpc_security_group.kibana.id
  description = "Kibana Security Group ID"
}

output "alb_sg_id" {
  value       = yandex_vpc_security_group.alb.id
  description = "Load Balancer Security Group ID"
}

#VM outputs
output "bastion_public_ip" {
  value       = yandex_compute_instance.bastion.network_interface.0.nat_ip_address
  description = "Public IP of Bastion host"
}

output "web_private_ips" {
  value = [
    yandex_compute_instance.web[0].network_interface.0.ip_address,
    yandex_compute_instance.web[1].network_interface.0.ip_address
  ]
  description = "Private IPs of Web servers"
}

output "zabbix_public_ip" {
  value       = yandex_compute_instance.zabbix.network_interface.0.nat_ip_address
  description = "Public IP of Zabbix"
}

output "elasticsearch_private_ip" {
  value       = yandex_compute_instance.elasticsearch.network_interface.0.ip_address
  description = "Private IP of Elasticsearch"
}

output "kibana_public_ip" {
  value       = yandex_compute_instance.kibana.network_interface.0.nat_ip_address
  description = "Public IP of Kibana"
}

output "alb_public_ip" {
  value       = yandex_alb_load_balancer.web.listener.0.endpoint.0.address.0.external_ipv4_address.0.address
  description = "Public IP of Application Load Balancer"
}


output "snapshot_schedule_id" {
  value       = yandex_compute_snapshot_schedule.daily.id
  description = "Snapshot Schedule ID"
}