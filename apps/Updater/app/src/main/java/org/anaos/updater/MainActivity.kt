package org.anaos.updater

import android.app.Activity
import android.os.Bundle
import android.widget.LinearLayout
import android.widget.TextView

/**
 * Dev UI: offline fixture self-test. Network OTA remains disabled by default.
 */
class MainActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val root = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(48, 48, 48, 48)
        }
        root.addView(
            TextView(this).apply {
                text = getString(R.string.updater_title)
                textSize = 20f
            },
        )
        root.addView(
            TextView(this).apply {
                text = getString(
                    R.string.updater_status_scaffold,
                    UpdateEndpoints.RELEASES_HOST,
                    UpdateChannel.STABLE.name,
                )
                textSize = 14f
                setPadding(0, 24, 0, 0)
            },
        )
        root.addView(
            TextView(this).apply {
                text = runFixtureSelfTest()
                textSize = 13f
                setPadding(0, 32, 0, 0)
            },
        )
        setContentView(root)
    }

    private fun runFixtureSelfTest(): String {
        return try {
            val json = assets.open("fixtures/stable_emulator_metadata.json")
                .bufferedReader()
                .use { it.readText() }
            val meta = UpdateMetadataParser.parse(json, UpdateChannel.STABLE)
            val repo = AllowlistedUpdateRepository(
                networkEnabled = true,
                fetchMetadataJson = { json },
            )
            val offer = repo.checkForUpdate(UpdateChannel.STABLE, "emulator", "2026100100")
            require(offer != null && offer.buildNumber == meta.buildNumber)
            "Fixture self-test: OK (parsed ${meta.buildNumber}, allowlist pass)"
        } catch (e: Exception) {
            "Fixture self-test: FAIL — ${e.message}"
        }
    }
}
