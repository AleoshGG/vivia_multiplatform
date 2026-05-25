
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vivia_multiplatform/features/auth/presentation/witgets/customTextField.dart';
import 'package:vivia_multiplatform/features/auth/presentation/witgets/headerLogo.dart';

import 'package:screen_protector/screen_protector.dart';

import '../witgets/footerButtons.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

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
                  const SizedBox(height: 32.0,),
                  const CustomFieldText(
                      labelText: 'Correo electrónico'
                  ),
                  const CustomFieldText(
                      labelText: "Contraseña",
                      obscureText: true,
                  ),
                  const SizedBox(height: 32.0,),
                  FooterButtons(
                    onLoginPressed: () {
                      // Inserte lógica de autenticación aquí
                    },
                    onCreateAccountPressed: () {
                      // Inserte lógica de navegación aquí
                    },
                  ),
                ],
              ),
            ),
          )),
    );

  }
}