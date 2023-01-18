terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.13.1"
    }
  }
}

locals {
  app = "redis"
  match_labels = {
    "app.kubernetes.io/name"     = "redis"
    "app.kubernetes.io/instance" = "redis"
  }
  labels = merge(local.match_labels, var.labels)
}

resource "kubernetes_stateful_set" "redis" {
  metadata {
    name      = var.stateful_set_name
    namespace = var.namespace
    labels    = local.labels
  }

  spec {
    selector {
      match_labels = local.match_labels
    }
    service_name = local.app
    template {
      metadata {
        labels = local.match_labels
      }
      spec {
        container {
          image   = var.image_registry == "" ? "${var.image_repository}:${var.image_tag}" : "${var.image_registry}/${var.image_repository}:${var.image_tag}"
          name    = var.container_name
          command = ["redis-server"]
          env {
            name  = "master"
            value = "true"
          }
          port {
            name           = "redis"
            container_port = 6379
          }
          volume_mount {
            name       = "data"
            mount_path = "/data"
          }
        }
      }
    }
    volume_claim_template {
      metadata {
        name = "data"
      }
      spec {
        access_modes = ["ReadWriteOnce"]
        resources {
          requests = {
            storage = var.storage_size
          }
        }
        storage_class_name = var.storage_class_name
      }
    }
  }
}

resource "kubernetes_service" "redis" {
  metadata {
    name      = var.service_name
    namespace = var.namespace
  }
  spec {
    port {
      name        = "redis"
      port        = 6379
      target_port = "redis"
    }
    type     = "ClusterIP"
    selector = local.match_labels
  }
}
