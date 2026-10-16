package org.anaos.updater

import android.app.Activity
import android.os.Bundle
import android.widget.TextView

/**
 * Placeholder UI until OTA client (TASK_060) is implemented against AnaOS servers only.
 */
class MainActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val tv = TextView(this)
        tv.text = "AnaOS Updater (scaffold)\nUpdates: releases.anaos.org"
        tv.textSize = 16f
        tv.setPadding(48, 48, 48, 48)
        setContentView(tv)
    }
}
