import 'dart:math';
import 'package:flutter/foundation.dart';

import '../../domain/entities/sensitive_data.dart';
import '../../domain/repositories/secure_storage_repository.dart';

/// Helper que auto-genera datos sensibles de prueba.
///
/// El compañero encargado de la UI puede llamarlo con un botón para
/// poblar el almacenamiento antes de demostrar el wipe remoto.
///
/// ```dart
/// // En cualquier botón de la UI:
/// final seeder = SensitiveDataSeeder(repository);
/// await seeder.seed();
/// ```
class SensitiveDataSeeder {
  final SecureStorageRepository _repository;

  const SensitiveDataSeeder(this._repository);

  /// Genera y guarda datos ficticios pero realistas.
  Future<SensitiveData> seed() async {
    final data = SensitiveData(
      nameCompany:       _generateToken(64),
      fullName:    _generateToken(128),
      email:         _generatePin(),
      password: _generateToken(32),
    );

    await _repository.saveSensitiveData(data);
    debugPrint('[Seeder] Datos sensibles generados y guardados.');
    return data;
  }

  // ─── Generators ──────────────────────────────────────────────────────────

  static const _chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  static const _digits = '0123456789';

  String _generateToken(int length) {
    final rng = Random.secure();
    return List.generate(length, (_) => _chars[rng.nextInt(_chars.length)])
        .join();
  }

  String _generatePin({int digits = 6}) {
    final rng = Random.secure();
    return List.generate(digits, (_) => _digits[rng.nextInt(10)]).join();
  }
}