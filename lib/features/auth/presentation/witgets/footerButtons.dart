import 'package:flutter/material.dart';

class FooterButtons extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onCreateAccountPressed;

  const FooterButtons({
    super.key,
    required this.onLoginPressed,
    required this.onCreateAccountPressed,
});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          ElevatedButton(
              onPressed: onLoginPressed,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50)
              ),
              child: const Text('Iniciar Sesión')
          ),

          const SizedBox(height: 16.0),

          TextButton(
              onPressed: onCreateAccountPressed,
              child: const Text(
                "Crear Cuenta",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ))
        ],
      ),
    );

  }


}