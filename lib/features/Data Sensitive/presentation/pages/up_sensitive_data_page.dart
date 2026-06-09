import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivia_multiplatform/features/Data Sensitive/presentation/witgets/save_data_button.dart';
import 'package:vivia_multiplatform/features/Data Sensitive/presentation/witgets/sensitive_data_field.dart';
import 'package:vivia_multiplatform/features/secure_storage/domain/entities/sensitive_data.dart';
import 'package:vivia_multiplatform/features/secure_storage/presentation/providers/secure_storage_provider.dart';

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
  void initState() {
    super.initState();
    // Poblar los campos si ya hay datos cargados
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<SecureStorageProvider>();
      if (provider.hasData) {
        _populateFields(provider.currentData);
      }
    });
  }

  void _populateFields(SensitiveData data) {
    _companyController.text = data.nameCompany ?? '';
    _fullNameController.text = data.fullName ?? '';
    _emailController.text = data.email ?? '';
    _passwordController.text = data.password ?? '';
  }

  @override
  void dispose() {
    _companyController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    final provider = context.read<SecureStorageProvider>();

    final newData = SensitiveData(
      nameCompany: _companyController.text,
      fullName: _fullNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    await provider.save(newData);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos guardados en Secure Storage')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final secureStorage = context.watch<SecureStorageProvider>();
    final hasData = secureStorage.hasData;
    final fullName = secureStorage.currentData.fullName;

    // Si los datos fueron borrados (ej. wipe remoto), limpiar controladores
    if (secureStorage.status == SecureStorageStatus.wiped) {
      _companyController.clear();
      _fullNameController.clear();
      _emailController.clear();
      _passwordController.clear();
    }

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
              Text(
                hasData ? 'Hola $fullName' : 'No hay datos cargados',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A3C50),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Datos sensibles',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF546E7A),
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
              if (secureStorage.status == SecureStorageStatus.loading)
                const Center(child: CircularProgressIndicator())
              else
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