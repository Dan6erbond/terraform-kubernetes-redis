variable "namespace" {
  description = "Namespace to deploy Redis to"
  type        = string
  default     = "default"
}

variable "labels" {
  description = "Labels to add to the Redis deployment"
  type        = map(any)
  default     = {}
}

variable "stateful_set_name" {
  description = "Name of StatefulSet"
  type        = string
  default     = "redis"
}

variable "storage_size" {
  description = "Storage size for StatefulSet PVC"
  type        = string
  default     = "5Gi"
}

variable "storage_class_name" {
  description = "Storage class to use for StatefulSet PVCs"
  type        = string
  default     = ""
}

variable "image_registry" {
  description = "Image registry, e.g. gcr.io, docker.io"
  type        = string
  default     = ""
}

variable "image_repository" {
  description = "Image to start for this pod"
  type        = string
  default     = "redis"
}

variable "image_tag" {
  description = "Image tag to use"
  type        = string
  default     = "7.0.4"
}

variable "container_name" {
  description = "Name of the Redis container"
  type        = string
  default     = "redis"
}

variable "service_name" {
  description = "Name of service to deploy"
  type        = string
  default     = "redis"
}

variable "service_type" {
  description = "Type of service to deploy"
  type        = string
  default     = "ClusterIP"
}
