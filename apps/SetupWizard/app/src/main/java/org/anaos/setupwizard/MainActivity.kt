package org.anaos.setupwizard

import android.app.Activity
import android.os.Bundle
import android.widget.TextView

/** Placeholder first-boot wizard (TASK_062). */
class MainActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(
            TextView(this).apply {
                text = getString(R.string.setup_scaffold)
                textSize = 18f
                setPadding(48, 48, 48, 48)
            },
        )
    }
}
