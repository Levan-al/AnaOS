package org.anaos.updater

/**
 * Future network client shape. Still **offline by default**.
 *
 * When [networkEnabled] is false (production default until domains + signed
 * metadata exist), behaves like [NoOpUpdateRepository].
 * When true, only HTTPS to [UpdateEndpoints.allowedHosts] is permitted —
 * callers must inject a real fetcher; this class does not open sockets itself.
 */
class AllowlistedUpdateRepository(
    private val networkEnabled: Boolean = false,
    private val fetchMetadataJson: ((url: String) -> String)? = null,
) : UpdateRepository {
    override fun checkForUpdate(
        channel: UpdateChannel,
        device: String,
        currentBuild: String,
    ): UpdateMetadata? {
        if (!networkEnabled || fetchMetadataJson == null) return null
        val url = UpdateEndpoints.metadataUrl(channel, device)
        require(HostAllowlist.isAllowedUrl(url)) { "metadata URL not allowlisted" }
        val json = fetchMetadataJson.invoke(url)
        val meta = UpdateMetadataParser.parse(json, channel)
        if (meta.buildNumber == currentBuild) return null
        return meta
    }
}
