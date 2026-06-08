import '../entities/sensitive_data.dart';
import '../repositories/secure_storage_repository.dart';

/// Caso de uso: leer datos sensibles del usuario.
class ReadSensitiveDataUseCase {
  final SecureStorageRepository _repository;

  const ReadSensitiveDataUseCase(this._repository);

  Future<SensitiveData> call() => _repository.readSensitiveData();
}