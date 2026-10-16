package org.anaos.pdfviewer

import android.app.Activity
import android.os.Bundle
import android.widget.TextView

/** Placeholder until pdf.js WebView path (TASK_058). */
class MainActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(
            TextView(this).apply {
                text = getString(R.string.pdf_scaffold)
                textSize = 16f
                setPadding(48, 48, 48, 48)
            },
        )
    }
}
