import 'package:flutter/foundation.dart';

import '../../domain/entities/sensitive_data.dart';
import '../../domain/repositories/secure_storage_repository.dart';
import '../../data/datasource/secure_storage_datasource.dart';


/// Implementación concreta de [SecureStorageRepository].
/// Coordina las operaciones con [SecureStorageDataSource] y
/// hace logging en modo debug para facilitar el desarrollo.
class SecureStorageRepositoryImpl implements SecureStorageRepository {
  final SecureStorageDataSource _dataSource;

  const SecureStorageRepositoryImpl(this._dataSource);

  @override
  Future<void> saveSensitiveData(SensitiveData data) async {
    final futures = <Future>[];

    if (data.nameCompany != null) {
      futures.add(_dataSource.saveNameCompany(data.nameCompany!));
    }
    if (data.fullName != null) {
      futures.add(_dataSource.saveFullName(data.fullName!));
    }
    if (data.email != null) {
      futures.add(_dataSource.saveEmail(data.email!));
    }
    if (data.password != null) {
      futures.add(_dataSource.savePassword(data.password!));
    }

    await Future.wait(futures);
    debugPrint('[SecureStorage] Datos sensibles guardados correctamente.');
  }

  @override
  Future<SensitiveData> readSensitiveData() async {
    final results = await Future.wait([
      _dataSource.readCompanyName(),
      _dataSource.readFullName(),
      _dataSource.readEmail(),
      _dataSource.readPassword(),
    ]);

    return SensitiveData(
      nameCompany:       results[0],
      fullName:    results[1],
      email:         results[2],
      password: results[3],
    );
  }

  @override
  Future<void> wipeAllData() async {
    await _dataSource.deleteAllSensitiveData();
    debugPrint('[SecureStorage] ⚠️  WIPE REMOTO ejecutado — datos eliminados.');
  }
}