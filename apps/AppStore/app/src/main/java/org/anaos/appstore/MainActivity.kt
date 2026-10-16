package org.anaos.appstore

import android.app.Activity
import android.os.Bundle
import android.widget.TextView

/** Placeholder until store client (TASK_061). */
class MainActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(
            TextView(this).apply {
                text = getString(R.string.store_scaffold)
                textSize = 16f
                setPadding(48, 48, 48, 48)
            },
        )
    }
}
