output "redis_namespace_host" {
  description = "Hostname of the Redis service in the namespace"
  value       = "${kubernetes_service.redis.metadata.0.name}"
}
