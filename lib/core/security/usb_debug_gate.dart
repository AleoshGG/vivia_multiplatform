import 'package:flutter/material.dart';
import 'package:vivia_multiplatform/core/security/usb_debug_guard.dart';
import 'package:vivia_multiplatform/shared/widgets/usb_debug_alert.dart';

/// Widget gate que verifica el estado de la Depuración USB
/// al inicio del ciclo de vida (initState) y, de detectarse
/// activa fuera de modo debug, muestra el AlertDialog bloqueante.
class UsbDebugGate extends StatefulWidget {
  final Widget child;

  const UsbDebugGate({super.key, required this.child});

  @override
  State<UsbDebugGate> createState() => _UsbDebugGateState();
}

class _UsbDebugGateState extends State<UsbDebugGate> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUsbDebugging();
    });
  }

  Future<void> _checkUsbDebugging() async {
    final bool isEnabled = await UsbDebugGuard.isUsbDebuggingEnabled();
    if (isEnabled && mounted) {
      UsbDebugAlert.show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}