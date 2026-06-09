import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivia_multiplatform/core/navigation/navigation_service.dart';
import 'package:vivia_multiplatform/features/secure_storage/data/datasource/secure_storage_datasource.dart';
import 'package:vivia_multiplatform/features/secure_storage/data/repositories/secure_storage_repository_impl.dart';
import 'package:vivia_multiplatform/features/secure_storage/domain/use_cases/wipe_all_data_usecase.dart';
import 'package:vivia_multiplatform/features/secure_storage/presentation/providers/secure_storage_provider.dart';

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

  static void _setupForegroundListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Mensaje recibido en primer plano: ${message.data}');
      }
      
      _handleDataMessage(message, isForeground: true);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Se abrió la app desde una notificación: ${message.data}');
      }
      _handleDataMessage(message, isForeground: true);
    });
  }

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    if (kDebugMode) {
      print("Manejando mensaje en segundo plano: ${message.data}");
    }
    await _handleDataMessage(message, isForeground: false);
  }

  static Future<void> _handleDataMessage(RemoteMessage message, {required bool isForeground}) async {
    final data = message.data;
    
    if (data['action'] == 'delete_account') {
      if (kDebugMode) {
        print('[FCM] Remote Wipe action detected.');
      }
      
      await _performWipe(isForeground: isForeground);
    }
  }

  static Future<void> _performWipe({required bool isForeground}) async {
    // Si estamos en primer plano, usamos el provider para que la UI reaccione
    if (isForeground) {
      final context = NavigationService.navigatorKey.currentContext;
      if (context != null) {
        // Ejecutar el wipe a través del provider
        await context.read<SecureStorageProvider>().wipe();
        
        // Mostrar alerta en la UI
        _showWipeAlert(context);
      }
    } else {
      // En segundo plano no hay context/provider, inicializamos el UseCase manualmente
      final dataSource = SecureStorageDataSource();
      final repository = SecureStorageRepositoryImpl(dataSource);
      final wipeUseCase = WipeAllDataUseCase(repository);
      
      await wipeUseCase();
      if (kDebugMode) {
        print('[FCM] Wipe ejecutado en segundo plano exitosamente.');
      }
    }
  }

  static void _showWipeAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(
          'Seguridad',
          style: TextStyle(color: Color(0xFF1A3C50), fontWeight: FontWeight.bold),
        ),
        content: const Text('Datos sensibles borrados por seguridad remota.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }
}
