import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FakeGpsAlert {
  static void show(BuildContext context) {

    Timer(const Duration(seconds: 7), () {
      _closeApp();
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Violación de Seguridad',
            style: TextStyle(color: Colors.red),
          ),
          content: const Text(
            'Hemos detectado el uso de una ubicación falsa.\n'
            'Por favor, desactívala para poder utilizar esta plataforma.',
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => _closeApp(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Salir'),
            ),
          ],
        );
      },
    );
  }

  static void _closeApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
}
