import 'package:flutter/material.dart';
import 'package:vivia_multiplatform/features/auth/presentation/pages/sign_in_page.dart';
import 'package:vivia_multiplatform/shared/theme/theme.dart';
import 'package:vivia_multiplatform/shared/theme/util.dart';
import 'package:vivia_multiplatform/core/security/global_security_gate.dart';
import 'package:vivia_multiplatform/core/security/screenshot_guard.dart';
import 'package:vivia_multiplatform/core/navigation/navigation_service.dart';
import 'package:vivia_multiplatform/core/security/usb_debug_gate.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Vivia Multiplatform',
      navigatorKey: NavigationService.navigatorKey, // Llave maestra de navegación
      debugShowCheckedModeBanner: false,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      builder: (context, child) {
        return GlobalSecurityGate(child: child!);
      },
        home: const ScreenshotGuard(
          child: UsbDebugGate(
            child: SignInPage(),
          ),
        ),
    );
  }
}