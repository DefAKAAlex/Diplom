# Security Group для Bastion
resource "yandex_vpc_security_group" "bastion" {
  name        = "bastion-sg"
  description = "Security group for bastion host"
  network_id  = yandex_vpc_network.diplom.id

  ingress {
    protocol       = "TCP"
    description    = "SSH from anywhere"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
  ingress {
    protocol       = "TCP"
    description    = "Zabbix agent"
    v4_cidr_blocks = ["10.0.1.0/24"]
    port           = 10050
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outgoing"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group для Web серверов
resource "yandex_vpc_security_group" "web" {
  name        = "web-sg"
  description = "Security group for web servers"
  network_id  = yandex_vpc_network.diplom.id

  ingress {
    protocol       = "TCP"
    description    = "HTTP from load balancer"
    v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"] # Из публичных подсетей
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "SSH from bastion"
    v4_cidr_blocks = ["10.0.1.0/24"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "Zabbix agent"
    v4_cidr_blocks = ["10.0.1.0/24"]
    port           = 10050
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outgoing"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group для Zabbix
resource "yandex_vpc_security_group" "zabbix" {
  name        = "zabbix-sg"
  description = "Security group for Zabbix"
  network_id  = yandex_vpc_network.diplom.id

  ingress {
    protocol       = "TCP"
    description    = "Zabbix web UI"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "Zabbix server port"
    v4_cidr_blocks = ["10.0.10.0/24", "10.0.11.0/24"] # Из приватных подсетей
    port           = 10051
  }

  ingress {
    protocol       = "TCP"
    description    = "SSH from bastion"
    v4_cidr_blocks = ["10.0.1.0/24"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outgoing"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group для Elasticsearch
resource "yandex_vpc_security_group" "elasticsearch" {
  name        = "elasticsearch-sg"
  description = "Security group for Elasticsearch"
  network_id  = yandex_vpc_network.diplom.id

  ingress {
    protocol       = "TCP"
    description    = "Elasticsearch API"
    v4_cidr_blocks = ["10.0.1.0/24"] # Только из публичной подсети (Kibana)
    port           = 9200
  }

  ingress {
    protocol       = "TCP"
    description    = "Elasticsearch from web servers"
    v4_cidr_blocks = ["10.0.10.0/24", "10.0.11.0/24"]
    port           = 9200
  }

  ingress {
    protocol       = "TCP"
    description    = "Zabbix agent"
    v4_cidr_blocks = ["10.0.1.0/24"]
    port           = 10050
  }

  ingress {
    protocol       = "TCP"
    description    = "SSH from bastion"
    v4_cidr_blocks = ["10.0.1.0/24"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outgoing"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group для Kibana
resource "yandex_vpc_security_group" "kibana" {
  name        = "kibana-sg"
  description = "Security group for Kibana"
  network_id  = yandex_vpc_network.diplom.id

  ingress {
    protocol       = "TCP"
    description    = "Kibana web UI"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 5601
  }

  ingress {
    protocol       = "TCP"
    description    = "Zabbix agent"
    v4_cidr_blocks = ["10.0.1.0/24"]
    port           = 10050
  }

  ingress {
    protocol       = "TCP"
    description    = "SSH from bastion"
    v4_cidr_blocks = ["10.0.1.0/24"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outgoing"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group для Load Balancer (входящий HTTP)
resource "yandex_vpc_security_group" "alb" {
  name        = "alb-sg"
  description = "Security group for Application Load Balancer"
  network_id  = yandex_vpc_network.diplom.id

  ingress {
    protocol       = "TCP"
    description    = "HTTP from anywhere"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outgoing"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
