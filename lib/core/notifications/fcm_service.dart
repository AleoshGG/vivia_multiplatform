import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FCMService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    // 1. Solicitar permisos
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('Permiso concedido');
      }
      
      // 2. Obtener Token
      String? token = await _messaging.getToken();
      if (kDebugMode) {
        print("================ FCM TOKEN ================");
        print(token);
        print("===========================================");
      }

      // 3. Configurar listeners
      _setupForegroundListener();
    } else {
      if (kDebugMode) {
        print('Permiso denegado por el usuario');
      }
    }
  }

  // Escuchar mensajes cuando la app está abierta en primer plano
  static void _setupForegroundListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Mensaje recibido en primer plano: ${message.notification?.title}');
        print('Cuerpo: ${message.notification?.body}');
      }
      // Aquí podrías mostrar un diálogo o un snackbar local si lo deseas
    });

    // Manejar cuando el usuario toca la notificación estando la app en segundo plano
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Se abrió la app desde una notificación: ${message.data}');
      }
    });
  }

  // Función estática para manejar mensajes en segundo plano (Requerido por FCM)
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // Este código se ejecuta en un isolate separado
    if (kDebugMode) {
      print("Manejando mensaje en segundo plano: ${message.messageId}");
    }
  }
}
