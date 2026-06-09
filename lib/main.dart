import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';
import 'package:vivia_multiplatform/core/notifications/fcm_service.dart';
import 'package:vivia_multiplatform/core/security/security_provider.dart';
import 'package:vivia_multiplatform/features/secure_storage/data/datasource/secure_storage_datasource.dart';
import 'package:vivia_multiplatform/features/secure_storage/data/repositories/secure_storage_repository_impl.dart';
import 'package:vivia_multiplatform/features/secure_storage/domain/use_cases/read_sensitive_data_usecase.dart';
import 'package:vivia_multiplatform/features/secure_storage/domain/use_cases/save_sensitive_data_usecase.dart';
import 'package:vivia_multiplatform/features/secure_storage/domain/use_cases/wipe_all_data_usecase.dart';
import 'package:vivia_multiplatform/features/secure_storage/presentation/providers/secure_storage_provider.dart';
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

  // Secure Storage Dependencies
  final secureDataSource = SecureStorageDataSource();
  final secureRepository = SecureStorageRepositoryImpl(secureDataSource);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SecurityProvider()),
        ChangeNotifierProvider(
          create: (_) => SecureStorageProvider(
            saveUseCase: SaveSensitiveDataUseCase(secureRepository),
            readUseCase: ReadSensitiveDataUseCase(secureRepository),
            wipeUseCase: WipeAllDataUseCase(secureRepository),
          )..read(),
        ),
      ],
      child: DevicePreview(
        enabled: kIsWeb,
        builder: (context) => const MyApp(),
      ),
    ),
  );
}


