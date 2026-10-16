package org.anaos.updater

import android.app.Activity
import android.os.Bundle
import android.widget.LinearLayout
import android.widget.TextView

/**
 * Placeholder UI until OTA client (TASK_060) talks to AnaOS servers only.
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
        setContentView(root)
    }
}
