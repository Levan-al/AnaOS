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
        if (!BuildNumber.isNewer(meta.buildNumber, currentBuild)) return null
        val min = meta.minBuildNumber
        if (min != null && !BuildNumber.isAtLeast(currentBuild, min)) {
            throw IllegalStateException(
                "rollback/minBuild blocked: current=$currentBuild min=$min",
            )
        }
        return meta
    }

    companion object {
        /** Offline default. Wire [HttpsMetadataFetcher]::fetch only after domains + signing. */
        fun productionOffline(): AllowlistedUpdateRepository = AllowlistedUpdateRepository()

        fun withHttps(networkEnabled: Boolean): AllowlistedUpdateRepository =
            AllowlistedUpdateRepository(
                networkEnabled = networkEnabled,
                fetchMetadataJson = HttpsMetadataFetcher::fetch,
            )
    }
}
