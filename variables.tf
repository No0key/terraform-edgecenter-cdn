variable "origin_groups" {
  description = "Origin group definition for CDN"
  type = object({
    name     = string
    use_next = bool
    origins = list(object({
      source  = string
      enabled = bool
    }))
  })
}

variable "resources" {
  description = "CDN resource definition"
  type = map(object({
    cname               = string
    active              = bool
    ssl_automated       = optional(bool)
    ssl_data            = optional(number)
    ssl_enabled         = optional(bool)
    description         = optional(string)
    issue_le_cert       = optional(bool)
    origin_group        = optional(number)
    secondary_hostnames = optional(set(string))
  }))
}

variable "resource_options" {
  description = "The options for the CDN resource"
  type = object({
    allowed_http_methods           = object({ value = set(string), enabled = optional(bool) })
    brotli_compression             = object({ value = set(string), enabled = optional(bool) })
    browser_cache_settings         = object({ enabled = optional(bool), value = optional(string) })
    cache_http_headers             = object({ value = set(string), enabled = optional(bool) })
    cors                           = object({ value = set(string), always = optional(bool), enabled = optional(bool, false) })
    country_acl                    = object({ excepted_values = set(string), policy_type = string, enabled = optional(bool) })
    disable_proxy_force_ranges     = object({ value = bool, enabled = optional(bool) })
    edge_cache_settings            = object({ custom_values = optional(map(string)), default = optional(string), enabled = optional(bool), value = optional(string) })
    fetch_compressed               = object({ value = bool, enabled = optional(bool) })
    follow_origin_redirect         = object({ codes = set(number), enabled = optional(bool), use_host = optional(bool) })
    force_return                   = object({ code = number, body = optional(string), enabled = optional(bool) })
    forward_host_header            = object({ value = bool, enabled = optional(bool) })
    gzip_on                        = object({ value = bool, enabled = optional(bool) })
    host_header                    = object({ value = string, enabled = optional(bool) })
    ignore_cookie                  = object({ value = bool, enabled = optional(bool) })
    ignore_query_string            = object({ value = bool, enabled = optional(bool) })
    image_stack                    = object({ quality = number, avif_enabled = optional(bool), enabled = optional(bool), png_lossless = optional(bool), webp_enabled = optional(bool) })
    ip_address_acl                 = object({ excepted_values = set(string), policy_type = string, enabled = optional(bool) })
    limit_bandwidth                = object({ limit_type = string, buffer = optional(number), enabled = optional(bool), speed = optional(number) })
    proxy_cache_methods_set        = object({ value = bool, enabled = optional(bool) })
    query_params_blacklist         = object({ value = set(string), enabled = optional(bool) })
    query_params_whitelist         = object({ value = set(string), enabled = optional(bool) })
    redirect_http_to_https         = object({ value = bool, enabled = optional(bool) })
    redirect_https_to_http         = object({ value = bool, enabled = optional(bool) })
    referrer_acl                   = object({ excepted_values = set(string), policy_type = string, enabled = optional(bool) })
    response_headers_hiding_policy = object({ excepted = set(string), mode = string, enabled = optional(bool) })
    rewrite                        = object({ body = string, enabled = optional(bool), flag = optional(string) })
    secure_key                     = object({ key = string, type = number, enabled = optional(bool) })
    slice                          = object({ value = bool, enabled = optional(bool) })
    sni                            = object({ custom_hostname = optional(string), enabled = optional(bool), sni_type = optional(string) })
    stale                          = object({ value = set(string), enabled = optional(bool) })
    static_headers                 = object({ value = map(string), enabled = optional(bool) })
    static_request_headers         = object({ value = map(string), enabled = optional(bool) })
    static_response_headers        = object({ value = list(object({ name = string, value = set(string), always = optional(bool) })), enabled = optional(bool) })
    user_agent_acl                 = object({ excepted_values = set(string), policy_type = string, enabled = optional(bool) })
    websockets                     = object({ value = bool, enabled = optional(bool) })
  })
  #TODO fix default values from UI
  default = {
    allowed_http_methods           = { value = ["GET", "HEAD"], enabled = false }
    brotli_compression             = { value = [""], enabled = false }
    browser_cache_settings         = { enabled = false, value = "" }
    cache_http_headers             = { value = [], enabled = false }
    cors                           = { value = [], always = false, enabled = false }
    country_acl                    = { excepted_values = [], policy_type = "", enabled = false }
    disable_proxy_force_ranges     = { value = false, enabled = false }
    edge_cache_settings            = { custom_values = {}, default = "2d", enabled = true, value = "" }
    fetch_compressed               = { value = false, enabled = false }
    follow_origin_redirect         = { codes = [], enabled = false, use_host = false }
    force_return                   = { code = 0, body = "", enabled = false }
    forward_host_header            = { value = false, enabled = false }
    gzip_on                        = { value = false, enabled = false }
    host_header                    = { value = "", enabled = false }
    ignore_cookie                  = { value = false, enabled = false }
    ignore_query_string            = { value = false, enabled = false }
    image_stack                    = { quality = 0, avif_enabled = false, enabled = false, png_lossless = false, webp_enabled = false }
    ip_address_acl                 = { excepted_values = [], policy_type = "", enabled = false }
    limit_bandwidth                = { limit_type = "", buffer = 0, enabled = false, speed = 0 }
    proxy_cache_methods_set        = { value = false, enabled = false }
    query_params_blacklist         = { value = [], enabled = false }
    query_params_whitelist         = { value = [], enabled = false }
    redirect_http_to_https         = { value = false, enabled = false }
    redirect_https_to_http         = { value = false, enabled = false }
    referrer_acl                   = { excepted_values = [], policy_type = "", enabled = false }
    response_headers_hiding_policy = { excepted = [], mode = "", enabled = false }
    rewrite                        = { body = "", enabled = false, flag = "" }
    secure_key                     = { key = "", type = 0, enabled = false }
    slice                          = { value = false, enabled = false }
    sni                            = { custom_hostname = "", enabled = false, sni_type = "" }
    stale                          = { value = [], enabled = false }
    static_headers                 = { value = {}, enabled = false }
    static_request_headers         = { value = {}, enabled = false }
    static_response_headers        = { value = [{ name = "", value = [], always = false }], enabled = false }
    user_agent_acl                 = { excepted_values = [], policy_type = "", enabled = false }
    websockets                     = { value = false, enabled = false }
  }
}

variable "ssl_certificate_name" {
  description = "SSL certificate"
  type        = string
  default     = ""
}

variable "ssl_certificate_fullchain" {
  description = "SSL ceritificate full chain"
  type        = string
  default     = ""
}

variable "ssl_certificate_private_key" {
  description = "SSL certificate private key"
  type        = string
  default     = ""
}
