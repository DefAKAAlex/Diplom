variable "yc_token" {
  description = "Yandex Cloud OAuth token"
  type        = string
  sensitive   = true
}

variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "yc_folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "yc_zone_a" {
  description = "Yandex Cloud zone A"
  type        = string
  default     = "ru-central1-a"
}

variable "yc_zone_b" {
  description = "Yandex Cloud zone B"
  type        = string
  default     = "ru-central1-b"
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}