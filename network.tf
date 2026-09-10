# VPC
resource "yandex_vpc_network" "diplom" {
  name        = "diplom-vpc"
  description = "VPC for DiplomIskryanov"
}

# Публичные подсети
resource "yandex_vpc_subnet" "public_a" {
  name           = "subnet-public-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

resource "yandex_vpc_subnet" "public_b" {
  name           = "subnet-public-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["10.0.2.0/24"]
}

# Приватные подсети
resource "yandex_vpc_subnet" "private_a" {
  name           = "subnet-private-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["10.0.10.0/24"]
  route_table_id = yandex_vpc_route_table.nat.id
}

resource "yandex_vpc_subnet" "private_b" {
  name           = "subnet-private-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["10.0.11.0/24"]
  route_table_id = yandex_vpc_route_table.nat.id
}

# NAT Gateway для приватных подсетей (исходящий интернет)
resource "yandex_vpc_gateway" "nat" {
  name = "nat-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "nat" {
  name       = "nat-route-table"
  network_id = yandex_vpc_network.diplom.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat.id
  }
}