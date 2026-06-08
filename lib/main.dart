import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';
import 'package:vivia_multiplatform/core/notifications/fcm_service.dart';
import 'package:vivia_multiplatform/core/security/security_provider.dart';
import 'app.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // 2. Inicializa Firebase con las opciones de tu proyecto
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 3. Configura el manejador de notificaciones en segundo plano
  FirebaseMessaging.onBackgroundMessage(FCMService.firebaseMessagingBackgroundHandler);

  // 4. Inicializa el servicio de FCM (Permisos, Token y Listeners)
  await FCMService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SecurityProvider()),
      ],
      child: DevicePreview(
        enabled: kIsWeb,
        builder: (context) => const MyApp(),
      ),
    ),
  );
}


