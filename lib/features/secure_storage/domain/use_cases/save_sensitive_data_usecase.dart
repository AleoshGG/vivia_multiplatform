import '../entities/sensitive_data.dart';
import '../repositories/secure_storage_repository.dart';

class SaveSensitiveDataUseCase {
  final SecureStorageRepository _repository;

  const SaveSensitiveDataUseCase(this._repository);

  Future<void> call(SensitiveData data) => _repository.saveSensitiveData(data);
}