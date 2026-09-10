# Snapshot Schedule для всех ВМ
resource "yandex_compute_snapshot_schedule" "daily" {
  name = "daily-snapshot-schedule"

  schedule_policy {
    expression = "0 2 * * *" # Каждый день в 02:00 UTC
  }

  retention_period = "168h" # 7 дней (168 часов)

  snapshot_spec {
    description = "Daily snapshot"

  }

  disk_ids = [
    yandex_compute_instance.bastion.boot_disk[0].disk_id,
    yandex_compute_instance.web[0].boot_disk[0].disk_id,
    yandex_compute_instance.web[1].boot_disk[0].disk_id,
    yandex_compute_instance.zabbix.boot_disk[0].disk_id,
    yandex_compute_instance.elasticsearch.boot_disk[0].disk_id,
    yandex_compute_instance.kibana.boot_disk[0].disk_id,
  ]
}