package org.anaos.auditor

import android.app.Activity
import android.os.Bundle
import android.widget.TextView

/** Placeholder until attestation client lands (TASK_059 / TASK_074). */
class MainActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(
            TextView(this).apply {
                text = getString(R.string.auditor_scaffold)
                textSize = 16f
                setPadding(48, 48, 48, 48)
            },
        )
    }
}
