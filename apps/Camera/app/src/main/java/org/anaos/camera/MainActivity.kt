package org.anaos.camera

import android.app.Activity
import android.os.Bundle
import android.widget.TextView

/** Placeholder until Camera implementation (TASK_056). */
class MainActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(
            TextView(this).apply {
                text = getString(R.string.camera_scaffold)
                textSize = 16f
                setPadding(48, 48, 48, 48)
            },
        )
    }
}
