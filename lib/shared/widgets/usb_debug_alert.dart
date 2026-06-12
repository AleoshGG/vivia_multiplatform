import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UsbDebugAlert {
  /// Muestra un diálogo de bloqueo persistente (no descartable)
  /// que informa al usuario y cierra la app al confirmar.
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (BuildContext dialogContext) {
        return PopScope(
          canPop: false, // Bloquea el botón de retroceso
          child: AlertDialog(
            title: const Text(
              'Entorno No Seguro Detectado',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            content: const Text(
              'Hemos detectado que la Depuración USB (USB Debugging) '
                  'está activa en este dispositivo.\n\n'
                  'Por motivos de seguridad y protección de la información, '
                  'esta aplicación no puede ejecutarse en este entorno.\n\n'
                  'Por favor, desactiva la Depuración USB en:\n'
                  'Ajustes > Opciones de desarrollador > Depuración USB\n\n'
                  'y vuelve a abrir la aplicación.',
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => _closeApp(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Entendido y Salir'),
              ),
            ],
          ),
        );
      },
    );
  }

  static void _closeApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    } else {
      exit(0);
    }
  }
}