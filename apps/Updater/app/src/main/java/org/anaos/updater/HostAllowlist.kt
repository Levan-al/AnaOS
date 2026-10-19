package org.anaos.updater

import java.net.URI

/** Only AnaOS update hosts may appear in metadata or fetch URLs. */
object HostAllowlist {
    fun isAllowedHost(host: String?): Boolean {
        if (host.isNullOrBlank()) return false
        return UpdateEndpoints.allowedHosts().any { it.equals(host, ignoreCase = true) }
    }

    fun isAllowedUrl(url: String): Boolean {
        return try {
            val uri = URI(url)
            uri.scheme.equals("https", ignoreCase = true) && isAllowedHost(uri.host)
        } catch (_: Exception) {
            false
        }
    }
}
