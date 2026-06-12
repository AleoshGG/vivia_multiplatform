import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

/// Servicio encargado de consultar al canal nativo el estado
/// de la Depuración USB (ADB) en Android.
class UsbDebugGuard {
  static const MethodChannel _channel =
  MethodChannel('quantum.aleosh.online.vivia_multiplatform/security');

  /// Retorna `true` si la Depuración USB está activa.
  /// En modo debug (kDebugMode) siempre retorna `false`
  /// para no bloquear el flujo normal de desarrollo.
  static Future<bool> isUsbDebuggingEnabled() async {
    // Excepción para entorno de desarrollo
    if (kDebugMode) {
      return false;
    }

    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      try {
        final bool? result =
        await _channel.invokeMethod<bool>('isUsbDebuggingEnabled');
        return result ?? false;
      } on PlatformException catch (e) {
        debugPrint('Error verificando ADB: ${e.message}');
        return false;
      }
    }

    // En otras plataformas (iOS, etc.) no aplica esta verificación
    return false;
  }
}