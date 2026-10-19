package org.anaos.updater

import java.io.BufferedReader
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URI
import java.nio.charset.StandardCharsets

/**
 * HTTPS GET for update metadata. Refuses non-allowlisted hosts before connect.
 * Production stays offline until [AllowlistedUpdateRepository] enables network.
 */
object HttpsMetadataFetcher {
    fun fetch(url: String, connectTimeoutMs: Int = 15_000, readTimeoutMs: Int = 30_000): String {
        require(HostAllowlist.isAllowedUrl(url)) { "URL not allowlisted: $url" }
        val conn = (URI(url).toURL().openConnection() as HttpURLConnection).apply {
            requestMethod = "GET"
            instanceFollowRedirects = false
            connectTimeout = connectTimeoutMs
            readTimeout = readTimeoutMs
            setRequestProperty("Accept", "application/json")
            setRequestProperty("User-Agent", "AnaOS-Updater/0.1")
        }
        try {
            val code = conn.responseCode
            require(code in 200..299) { "HTTP $code for $url" }
            return BufferedReader(InputStreamReader(conn.inputStream, StandardCharsets.UTF_8)).use {
                it.readText()
            }
        } finally {
            conn.disconnect()
        }
    }
}
