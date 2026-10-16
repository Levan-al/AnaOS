package org.anaos.updater

/**
 * Contract for fetching and verifying update metadata.
 * Scaffold returns null — no network until TASK_066 servers exist.
 */
interface UpdateRepository {
    fun checkForUpdate(
        channel: UpdateChannel,
        device: String,
        currentBuild: String,
    ): UpdateMetadata?
}

/** Dev stub: never contacts the network. */
class NoOpUpdateRepository : UpdateRepository {
    override fun checkForUpdate(
        channel: UpdateChannel,
        device: String,
        currentBuild: String,
    ): UpdateMetadata? = null
}
