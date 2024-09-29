output "edgecenter_cdn_origingroup_id" {
  description = "The ID of the CDN Origin Group"
  value       = resource.edgecenter_cdn_origingroup.main[0].id
}

output "edgecenter_cdn_resource_id" {
  description = "The ID of the CDN Resource"
  value       = resource.edgecenter_cdn_resource.main[*].id
}

output "edgecenter_cdn_ssl_certificate_id" {
  description = "SSL certificate ID"
  value       = resource.edgecenter_cdn_sslcert.main[0].id
}
