import 'package:flutter/material.dart';
import 'package:screen_protector/screen_protector.dart';

class SecureWrapper extends StatefulWidget {
  final Widget child; // El widget o pantalla que vamos a proteger

  const SecureWrapper({
    super.key,
    required this.child,
  });

  @override
  State<SecureWrapper> createState() => _SecureWrapperState();
}

class _SecureWrapperState extends State<SecureWrapper> {
  @override
  void initState() {
    super.initState();
    _protectScreen();
  }

  Future<void> _protectScreen() async {
    await ScreenProtector.preventScreenshotOn();
  }

  @override
  void dispose() {
    // Apaga la protección al salir de la vista para no afectar el resto de la app
    ScreenProtector.preventScreenshotOff();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Simplemente devuelve el widget hijo que le pasamos
    return widget.child;
  }
}