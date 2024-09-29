
resource "edgecenter_cdn_origingroup" "main" {
  count    = var.origin_groups.name != "" ? 1 : 0
  name     = var.origin_groups.name
  use_next = try(var.origin_groups.use_next, true)
  dynamic "origin" {
    for_each = var.origin_groups.origins
    content {
      source  = origin.value.source
      enabled = origin.value.enabled
      backup  = lookup(origin.value, "backup", false)
    }
  }
}

resource "edgecenter_cdn_sslcert" "main" {
  count       = var.ssl_certificate_name != "" ? 1 : 0
  name        = var.ssl_certificate_name
  cert        = var.ssl_certificate_fullchain
  private_key = var.ssl_certificate_private_key
}

resource "edgecenter_cdn_resource" "main" {
  for_each            = { for k, v in var.resources : k => v }
  cname               = each.value.cname
  active              = each.value.active
  description         = lookup(each.value, "description", "")
  issue_le_cert       = lookup(each.value, "issue_le_cert", false)
  origin_group        = resource.edgecenter_cdn_origingroup.main[0].id
  secondary_hostnames = lookup(each.value, "secondary_hostnames", null)
  ssl_automated       = lookup(each.value, "ssl_automated", false)
  ssl_data            = lookup(each.value, "ssl_enabled", false) == true ? resource.edgecenter_cdn_sslcert.main[0].id : null
  ssl_enabled         = lookup(each.value, "ssl_enabled", false)
  options {
    dynamic "allowed_http_methods" {
      for_each = var.resource_options.allowed_http_methods.enabled ? [var.resource_options.allowed_http_methods] : []
      content {
        value   = allowed_http_methods.value.value
        enabled = allowed_http_methods.value.enabled
      }
    }

    dynamic "brotli_compression" {
      for_each = var.resource_options.brotli_compression.enabled ? [var.resource_options.brotli_compression] : []
      content {
        value   = brotli_compression.value.value
        enabled = brotli_compression.value.enabled
      }
    }

    browser_cache_settings {
      value   = var.resource_options.browser_cache_settings.value != null ? var.resource_options.browser_cache_settings.value : ""
      enabled = var.resource_options.browser_cache_settings.enabled
    }

    dynamic "cache_http_headers" {
      for_each = var.resource_options.cache_http_headers.enabled ? [var.resource_options.cache_http_headers] : []
      content {
        value   = cache_http_headers.value.value
        enabled = cache_http_headers.value.enabled
      }
    }

    dynamic "cors" {
      for_each = var.resource_options.cors.enabled ? [var.resource_options.cors] : []
      content {
        value   = cors.value.value
        always  = cors.value.always
        enabled = cors.value.enabled
      }
    }

    dynamic "country_acl" {
      for_each = var.resource_options.country_acl.enabled ? [var.resource_options.country_acl] : []
      content {
        excepted_values = country_acl.value.excepted_values
        policy_type     = country_acl.value.policy_type
        enabled         = country_acl.value.enabled
      }
    }

    dynamic "disable_proxy_force_ranges" {
      for_each = var.resource_options.disable_proxy_force_ranges.enabled ? [var.resource_options.disable_proxy_force_ranges] : []
      content {
        value   = disable_proxy_force_ranges.value.value
        enabled = disable_proxy_force_ranges.value.enabled
      }
    }

    dynamic "edge_cache_settings" {
      for_each = var.resource_options.edge_cache_settings.enabled ? [var.resource_options.edge_cache_settings] : []
      content {
        custom_values = edge_cache_settings.value.custom_values
        default       = edge_cache_settings.value.default
        enabled       = edge_cache_settings.value.enabled
        value         = edge_cache_settings.value.value
      }
    }

    dynamic "fetch_compressed" {
      for_each = var.resource_options.fetch_compressed.enabled ? [var.resource_options.fetch_compressed] : []
      content {
        value   = fetch_compressed.value.value
        enabled = fetch_compressed.value.enabled
      }
    }

    dynamic "follow_origin_redirect" {
      for_each = var.resource_options.follow_origin_redirect.enabled ? [var.resource_options.follow_origin_redirect] : []
      content {
        codes    = follow_origin_redirect.value.codes
        enabled  = follow_origin_redirect.value.enabled
        use_host = follow_origin_redirect.value.use_host
      }
    }

    dynamic "force_return" {
      for_each = var.resource_options.force_return.enabled ? [var.resource_options.force_return] : []
      content {
        code    = force_return.value.code
        body    = force_return.value.body
        enabled = force_return.value.enabled
      }
    }

    dynamic "forward_host_header" {
      for_each = var.resource_options.forward_host_header.enabled ? [var.resource_options.forward_host_header] : []
      content {
        value   = forward_host_header.value.value
        enabled = forward_host_header.value.enabled
      }
    }

    dynamic "gzip_on" {
      for_each = var.resource_options.gzip_on.enabled ? [var.resource_options.gzip_on] : []
      content {
        value   = gzip_on.value.value
        enabled = gzip_on.value.enabled
      }
    }

    dynamic "host_header" {
      for_each = var.resource_options.host_header.enabled ? [var.resource_options.host_header] : []
      content {
        value   = host_header.value.value
        enabled = host_header.value.enabled
      }
    }

    dynamic "ignore_cookie" {
      for_each = var.resource_options.ignore_cookie.enabled ? [var.resource_options.ignore_cookie] : []
      content {
        value   = ignore_cookie.value.value
        enabled = ignore_cookie.value.enabled
      }
    }

    dynamic "ignore_query_string" {
      for_each = var.resource_options.ignore_query_string.enabled ? [var.resource_options.ignore_query_string] : []
      content {
        value   = ignore_query_string.value.value
        enabled = ignore_query_string.value.enabled
      }
    }

    dynamic "image_stack" {
      for_each = var.resource_options.image_stack.enabled ? [var.resource_options.image_stack] : []
      content {
        quality      = image_stack.value.quality
        avif_enabled = image_stack.value.avif_enabled
        enabled      = image_stack.value.enabled
        png_lossless = image_stack.value.png_lossless
        webp_enabled = image_stack.value.webp_enabled
      }
    }

    dynamic "ip_address_acl" {
      for_each = var.resource_options.ip_address_acl.enabled ? [var.resource_options.ip_address_acl] : []
      content {
        excepted_values = ip_address_acl.value.excepted_values
        policy_type     = ip_address_acl.value.policy_type
        enabled         = ip_address_acl.value.enabled
      }
    }

    dynamic "limit_bandwidth" {
      for_each = var.resource_options.limit_bandwidth.enabled ? [var.resource_options.limit_bandwidth] : []
      content {
        limit_type = limit_bandwidth.value.limit_type
        buffer     = limit_bandwidth.value.buffer
        enabled    = limit_bandwidth.value.enabled
        speed      = limit_bandwidth.value.speed
      }
    }

    dynamic "proxy_cache_methods_set" {
      for_each = var.resource_options.proxy_cache_methods_set.enabled ? [var.resource_options.proxy_cache_methods_set] : []
      content {
        value   = proxy_cache_methods_set.value.value
        enabled = proxy_cache_methods_set.value.enabled
      }
    }

    dynamic "query_params_blacklist" {
      for_each = var.resource_options.query_params_blacklist.enabled ? [var.resource_options.query_params_blacklist] : []
      content {
        value   = query_params_blacklist.value.value
        enabled = query_params_blacklist.value.enabled
      }
    }

    dynamic "query_params_whitelist" {
      for_each = var.resource_options.query_params_whitelist.enabled ? [var.resource_options.query_params_whitelist] : []
      content {
        value   = query_params_whitelist.value.value
        enabled = query_params_whitelist.value.enabled
      }
    }

    dynamic "redirect_http_to_https" {
      for_each = var.resource_options.redirect_http_to_https.enabled ? [var.resource_options.redirect_http_to_https] : []
      content {
        value   = redirect_http_to_https.value.value
        enabled = redirect_http_to_https.value.enabled
      }
    }

    dynamic "redirect_https_to_http" {
      for_each = var.resource_options.redirect_https_to_http.enabled ? [var.resource_options.redirect_https_to_http] : []
      content {
        value   = redirect_https_to_http.value.value
        enabled = redirect_https_to_http.value.enabled
      }
    }

    dynamic "referrer_acl" {
      for_each = var.resource_options.referrer_acl.enabled ? [var.resource_options.referrer_acl] : []
      content {
        excepted_values = referrer_acl.value.excepted_values
        policy_type     = referrer_acl.value.policy_type
        enabled         = referrer_acl.value.enabled
      }
    }

    dynamic "response_headers_hiding_policy" {
      for_each = var.resource_options.response_headers_hiding_policy.enabled ? [var.resource_options.response_headers_hiding_policy] : []
      content {
        excepted = response_headers_hiding_policy.value.excepted
        mode     = response_headers_hiding_policy.value.mode
        enabled  = response_headers_hiding_policy.value.enabled
      }
    }

    dynamic "rewrite" {
      for_each = var.resource_options.rewrite.enabled ? [var.resource_options.rewrite] : []
      content {
        body    = rewrite.value.body
        enabled = rewrite.value.enabled
        flag    = rewrite.value.flag
      }
    }

    dynamic "secure_key" {
      for_each = var.resource_options.secure_key.enabled ? [var.resource_options.secure_key] : []
      content {
        key     = secure_key.value.key
        type    = secure_key.value.type
        enabled = secure_key.value.enabled
      }
    }

    dynamic "slice" {
      for_each = var.resource_options.slice.enabled ? [var.resource_options.slice] : []
      content {
        value   = slice.value.value
        enabled = slice.value.enabled
      }
    }

    dynamic "sni" {
      for_each = var.resource_options.sni.enabled ? [var.resource_options.sni] : []
      content {
        custom_hostname = sni.value.custom_hostname != null ? sni.value.custom_hostname : ""
        enabled         = sni.value.enabled
        sni_type        = sni.value.sni_type != null ? sni.value.sni_type : ""
      }
    }

    dynamic "stale" {
      for_each = var.resource_options.stale.enabled ? [var.resource_options.stale] : []
      content {
        value   = stale.value.value
        enabled = stale.value.enabled
      }
    }

    dynamic "static_headers" {
      for_each = var.resource_options.static_headers.enabled ? [var.resource_options.static_headers] : []
      content {
        value   = static_headers.value.value
        enabled = static_headers.value.enabled
      }
    }

    dynamic "static_request_headers" {
      for_each = var.resource_options.static_request_headers.enabled ? [var.resource_options.static_request_headers] : []
      content {
        value   = static_request_headers.value.value
        enabled = static_request_headers.value.enabled
      }
    }

    dynamic "user_agent_acl" {
      for_each = var.resource_options.user_agent_acl.enabled ? [var.resource_options.user_agent_acl] : []
      content {
        excepted_values = user_agent_acl.value.excepted_values
        policy_type     = user_agent_acl.value.policy_type
        enabled         = user_agent_acl.value.enabled
      }
    }

    dynamic "websockets" {
      for_each = var.resource_options.websockets.enabled ? [var.resource_options.websockets] : []
      content {
        value   = websockets.value.value
        enabled = websockets.value.enabled
      }
    }

  }

  depends_on = [edgecenter_cdn_origingroup.main, edgecenter_cdn_sslcert.main]
}
