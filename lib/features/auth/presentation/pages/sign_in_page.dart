import 'package:flutter/material.dart';
import 'package:vivia_multiplatform/features/auth/presentation/witgets/custom_text_field.dart';
import 'package:vivia_multiplatform/features/auth/presentation/witgets/header_logo.dart';
import '../../../../core/navigation/navigation_service.dart';
import '../../../../core/security/session_timeout/session_timeout_service.dart';
import '../witgets/footer_buttons.dart';
import 'home_page.dart';

const _mockEmail = 'usuario@vivia.com';
const _mockPassword = '1234';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email == _mockEmail && password == _mockPassword) {

      SessionTimeoutService().start(
        onTimeout: () {
          NavigationService.navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const SignInPage()),
            (route) => false,
          );
        },
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Credenciales incorrectas'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const HeaderLogo(),
                const SizedBox(height: 32.0),
                CustomFieldText(
                  labelText: 'Correo electrónico',
                  controller: _emailController,
                ),
                CustomFieldText(
                  labelText: 'Contraseña',
                  obscureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 32.0),
                FooterButtons(
                  onLoginPressed: _handleLogin,
                  onCreateAccountPressed: () {
                    // TODO: navegar a registro
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}