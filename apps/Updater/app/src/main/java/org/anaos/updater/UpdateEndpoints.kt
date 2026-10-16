package org.anaos.updater

/**
 * Hard-coded AnaOS update origins. No third-party hosts.
 * Wired to product props (`ro.anaos.updater.uri`) once platform integration lands.
 */
object UpdateEndpoints {
    const val RELEASES_HOST = "releases.anaos.org"
    const val DOWNLOADS_HOST = "dl.anaos.org"

    fun metadataUrl(channel: UpdateChannel, device: String): String =
        "https://$RELEASES_HOST/${channel.pathSegment}/$device/metadata.json"

    fun allowedHosts(): Set<String> = setOf(RELEASES_HOST, DOWNLOADS_HOST)
}
