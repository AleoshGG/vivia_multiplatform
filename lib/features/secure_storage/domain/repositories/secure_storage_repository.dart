import '../entities/sensitive_data.dart';

abstract class SecureStorageRepository {
  Future<void> saveSensitiveData(SensitiveData data);
  Future<SensitiveData> readSensitiveData();


  Future<void> wipeAllData();
}