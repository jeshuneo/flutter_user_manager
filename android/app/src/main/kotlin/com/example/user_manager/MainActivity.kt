package com.example.user_manager

import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.user_manager/device_info"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "getDeviceInfo" -> {
                    val deviceInfo = mapOf(
                        "model" to Build.MODEL,
                        "manufacturer" to Build.MANUFACTURER,
                        "version" to Build.VERSION.RELEASE,
                        "sdk" to Build.VERSION.SDK_INT
                    )
                    result.success(deviceInfo)
                }
                "hasBiometricAuth" -> {
                    // Implementation for biometric check
                    result.success(true)
                }
                "isOrientationLocked" -> {
                    // Implementation for orientation lock check
                    result.success(false)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}