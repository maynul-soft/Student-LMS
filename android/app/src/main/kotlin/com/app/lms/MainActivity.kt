package com.app.lms

import android.os.Bundle
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // System UI কে edge-to-edge করার জন্য নতুন মেথড
        WindowCompat.setDecorFitsSystemWindows(window, false)
    }
}
