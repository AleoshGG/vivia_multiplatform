import 'package:flutter/material.dart';
import 'package:vivia_multiplatform/features/Data Sensitive/presentation/witgets/save_data_button.dart';
import 'package:vivia_multiplatform/features/Data Sensitive/presentation/witgets/sensitive_data_field.dart';



class UpSensitiveDataPage extends StatefulWidget {
  const UpSensitiveDataPage({super.key});

  @override
  State<UpSensitiveDataPage> createState() => _UpSensitiveDataPageState();
}

class _UpSensitiveDataPageState extends State<UpSensitiveDataPage> {
  final _companyController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _companyController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSave() {
    // TODO: Aquí va la lógica de guardado con flutter_secure_storage
    debugPrint('Empresa: ${_companyController.text}');
    debugPrint('Nombre: ${_fullNameController.text}');
    debugPrint('Correo: ${_emailController.text}');
    debugPrint('Contraseña: ${_passwordController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF1A3C50),
            size: 26,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Cargar Datos',
          style: TextStyle(
            color: Color(0xFF1A3C50),
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Datos sensibles',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A3C50),
                ),
              ),
              const SizedBox(height: 24),
              SensitiveDataField(
                label: 'Nombre de la Empresa',
                controller: _companyController,
                hintText: 'Ej. My HomeFriend',
              ),
              SensitiveDataField(
                label: 'Nombre completo',
                controller: _fullNameController,
                hintText: 'Ej. Arturo Elías Gómez Masa',
              ),
              SensitiveDataField(
                label: 'Correo electrónico',
                controller: _emailController,
                hintText: 'Ej. correo@ejemplo.com',
                keyboardType: TextInputType.emailAddress,
              ),
              SensitiveDataField(
                label: 'Contraseña',
                controller: _passwordController,
                hintText: 'Ingresa una contraseña',
                obscureText: true,
              ),
              const SizedBox(height: 32),
              SaveDataButton(
                onPressed: _onSave,
              ),
            ],
          ),
        ),
      ),
    );
  }
}