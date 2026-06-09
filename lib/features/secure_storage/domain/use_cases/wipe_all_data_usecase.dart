import '../repositories/secure_storage_repository.dart';

/// Caso de uso: eliminar remotamente todos los datos sensibles.
///
/// Este use case es el punto de entrada que el handler de FCM
/// (implementado por otro integrante del equipo) debe invocar
/// al recibir una notificación de wipe remoto dirigida a este usuario.
///
/// Ejemplo de uso desde el handler FCM:
/// ```dart
/// final wipeUseCase = sl<WipeAllDataUseCase>();
/// await wipeUseCase();
/// ```
class WipeAllDataUseCase {
  final SecureStorageRepository _repository;

  const WipeAllDataUseCase(this._repository);

  Future<void> call() => _repository.wipeAllData();
}