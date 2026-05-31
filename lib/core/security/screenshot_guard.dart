import 'package:flutter/material.dart';
import 'package:screen_protector/screen_protector.dart';

/// Wrapper quirúrgico para activar la protección de capturas de pantalla
/// únicamente en la vista donde se implemente.
class ScreenshotGuard extends StatefulWidget {
  final Widget child;

  const ScreenshotGuard({
    super.key,
    required this.child,
  });

  @override
  State<ScreenshotGuard> createState() => _ScreenshotGuardState();
}

class _ScreenshotGuardState extends State<ScreenshotGuard> {
  @override
  void initState() {
    super.initState();
    _enableProtection();
  }

  Future<void> _enableProtection() async {
    await ScreenProtector.preventScreenshotOn();
  }

  @override
  void dispose() {
    // Es vital desactivarlo al salir para que no afecte a las rutas que no lo necesitan
    ScreenProtector.preventScreenshotOff();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
