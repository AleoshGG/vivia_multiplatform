package quantum.aleosh.online.vivia_multiplatform

import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "quantum.aleosh.online.vivia_multiplatform/security"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "isUsbDebuggingEnabled" -> {
                    try {
                        val adbEnabled = Settings.Global.getInt(
                            contentResolver,
                            Settings.Global.ADB_ENABLED,
                            0
                        )
                        result.success(adbEnabled == 1)
                    } catch (e: Exception) {
                        result.error("UNAVAILABLE", "No se pudo leer el estado de ADB", e.message)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
}