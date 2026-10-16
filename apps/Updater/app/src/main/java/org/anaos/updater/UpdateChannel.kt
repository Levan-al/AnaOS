package org.anaos.updater

/**
 * OTA channels. Only AnaOS-operated hosts are allowed (see [UpdateEndpoints]).
 */
enum class UpdateChannel {
    STABLE,
    BETA;

    val pathSegment: String
        get() = when (this) {
            STABLE -> "stable"
            BETA -> "beta"
        }
}
