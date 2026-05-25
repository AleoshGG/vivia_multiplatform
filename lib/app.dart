import 'package:flutter/material.dart';
import 'package:vivia_multiplatform/features/auth/presentation/pages/signInPage.dart';
import 'package:vivia_multiplatform/shared/theme/theme.dart';
import 'package:vivia_multiplatform/shared/theme/util.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: SignInPage(),
    );
  }
}