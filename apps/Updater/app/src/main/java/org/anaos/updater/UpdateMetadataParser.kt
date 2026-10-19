package org.anaos.updater

import org.json.JSONObject

/**
 * Offline JSON → [UpdateMetadata] parser (Phase C scaffold).
 * Does not perform network I/O. Rejects non-allowlisted download hosts.
 */
object UpdateMetadataParser {
    fun parse(json: String, expectedChannel: UpdateChannel): UpdateMetadata {
        val root = JSONObject(json)
        val channelName = root.getString("channel")
        val channel = UpdateChannel.entries.firstOrNull { it.name.equals(channelName, ignoreCase = true) }
            ?: throw IllegalArgumentException("unknown channel: $channelName")
        if (channel != expectedChannel) {
            throw IllegalArgumentException("channel mismatch: got $channel expected $expectedChannel")
        }
        val downloadUrl = root.getString("downloadUrl")
        require(HostAllowlist.isAllowedUrl(downloadUrl)) {
            "downloadUrl host not in AnaOS allowlist: $downloadUrl"
        }
        fun optStr(key: String): String? =
            if (root.has(key) && !root.isNull(key)) root.getString(key).takeIf { it.isNotEmpty() } else null

        return UpdateMetadata(
            buildNumber = root.getString("buildNumber"),
            channel = channel,
            incremental = root.optBoolean("incremental", false),
            downloadUrl = downloadUrl,
            sha256 = root.getString("sha256"),
            minBuildNumber = optStr("minBuildNumber"),
            classicalSignature = optStr("classicalSignature"),
            pqSignature = optStr("pqSignature"),
        )
    }
}
