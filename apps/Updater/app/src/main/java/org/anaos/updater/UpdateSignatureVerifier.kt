package org.anaos.updater

/**
 * Verifies OTA / metadata signatures (TASK_100 / TRACK C).
 *
 * Production path: classical signature required; optional PQ half in hybrid mode.
 * Scaffold implementations never touch the network or load real keys.
 */
interface UpdateSignatureVerifier {
    fun verify(metadata: UpdateMetadata, payload: ByteArray): VerifyResult
}

enum class VerifyResult {
    /** Classical (and PQ if required) checks passed. */
    OK,

    /** Classical signature failed — reject always. */
    REJECT_CLASSICAL,

    /** Hybrid mode: classical OK but PQ half missing/invalid. */
    REJECT_PQ,

    /** Scaffold / not configured. */
    NOT_IMPLEMENTED,
}

/**
 * Dev stub: always [VerifyResult.NOT_IMPLEMENTED].
 * Wire real verify when release metadata + keys exist.
 */
class NoOpSignatureVerifier : UpdateSignatureVerifier {
    override fun verify(metadata: UpdateMetadata, payload: ByteArray): VerifyResult =
        VerifyResult.NOT_IMPLEMENTED
}

/**
 * Hybrid classical + post-quantum metadata verification (prototype shape).
 *
 * Both halves must succeed when [requirePq] is true. Classical failure always
 * rejects. See docs/PQC_ROADMAP.md.
 */
class HybridPqSignatureVerifier(
    private val requirePq: Boolean = true,
) : UpdateSignatureVerifier {
    override fun verify(metadata: UpdateMetadata, payload: ByteArray): VerifyResult {
        // Placeholder: real classical verify + PQ verify land with TASK_066 metadata.
        if (metadata.sha256.isEmpty() || payload.isEmpty()) {
            return VerifyResult.REJECT_CLASSICAL
        }
        // Until crypto is wired, do not claim success.
        return if (requirePq) VerifyResult.NOT_IMPLEMENTED else VerifyResult.NOT_IMPLEMENTED
    }
}
