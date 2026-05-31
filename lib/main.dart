import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';
import 'package:vivia_multiplatform/core/security/security_provider.dart';
import 'app.dart';

void main() {
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


