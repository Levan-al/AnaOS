package org.anaos.updater

/**
 * Minimal metadata shape expected from AnaOS update servers (TASK_066 / TASK_067).
 * Parsing + signature verify land with real OTA client work — not in this scaffold.
 */
data class UpdateMetadata(
    val buildNumber: String,
    val channel: UpdateChannel,
    val incremental: Boolean,
    val downloadUrl: String,
    val sha256: String,
    val minBuildNumber: String? = null,
)
