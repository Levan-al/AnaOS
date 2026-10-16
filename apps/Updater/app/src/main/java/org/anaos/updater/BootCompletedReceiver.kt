package org.anaos.updater

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log

/**
 * Schedules a future update check after boot. Scaffold logs only — no download.
 */
class BootCompletedReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent?) {
        if (intent?.action != Intent.ACTION_BOOT_COMPLETED) return
        Log.i(TAG, "boot completed — update check deferred (scaffold)")
    }

    companion object {
        private const val TAG = "AnaOSUpdater"
    }
}
