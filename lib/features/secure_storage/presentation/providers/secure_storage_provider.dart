import 'package:flutter/foundation.dart';

import '../../domain/entities/sensitive_data.dart';
import '../../domain/use_cases/save_sensitive_data_usecase.dart';
import '../../domain/use_cases/read_sensitive_data_usecase.dart';
import '../../domain/use_cases/wipe_all_data_usecase.dart';

enum SecureStorageStatus { idle, loading, success, wiped, error }

/// Provider que expone las operaciones de almacenamiento seguro a la UI.
///
/// Se registra en el árbol de providers junto al [SecurityProvider] existente.
/// El compañero que maneje FCM solo necesita llamar a [wipe()] desde su handler.
class SecureStorageProvider with ChangeNotifier {
  final SaveSensitiveDataUseCase _saveUseCase;
  final ReadSensitiveDataUseCase _readUseCase;
  final WipeAllDataUseCase       _wipeUseCase;

  SecureStorageProvider({
    required SaveSensitiveDataUseCase saveUseCase,
    required ReadSensitiveDataUseCase readUseCase,
    required WipeAllDataUseCase       wipeUseCase,
  })  : _saveUseCase = saveUseCase,
        _readUseCase = readUseCase,
        _wipeUseCase = wipeUseCase;

  // ─── State ───────────────────────────────────────────────────────────────

  SecureStorageStatus _status = SecureStorageStatus.idle;
  SensitiveData _currentData  = const SensitiveData();
  String? _errorMessage;

  SecureStorageStatus get status       => _status;
  SensitiveData       get currentData  => _currentData;
  String?             get errorMessage => _errorMessage;

  bool get hasData => !_currentData.isEmpty;

  // ─── Actions ─────────────────────────────────────────────────────────────

  /// Guarda datos sensibles en el almacenamiento seguro.
  Future<void> save(SensitiveData data) async {
    _setStatus(SecureStorageStatus.loading);
    try {
      await _saveUseCase(data);
      _currentData = data;
      _setStatus(SecureStorageStatus.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setStatus(SecureStorageStatus.error);
    }
  }

  /// Lee los datos sensibles actualmente almacenados.
  Future<void> read() async {
    _setStatus(SecureStorageStatus.loading);
    try {
      _currentData = await _readUseCase();
      _setStatus(SecureStorageStatus.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setStatus(SecureStorageStatus.error);
    }
  }

  /// Elimina todos los datos sensibles (wipe remoto).
  ///
  /// **Este es el método que el handler de FCM debe invocar** cuando
  /// reciba una notificación del tipo `remote_wipe` dirigida al usuario activo.
  ///
  /// ```dart
  /// // En el FCM message handler (implementado por otro integrante):
  /// final provider = context.read<SecureStorageProvider>();
  /// await provider.wipe();
  /// ```
  Future<void> wipe() async {
    _setStatus(SecureStorageStatus.loading);
    try {
      await _wipeUseCase();
      _currentData = const SensitiveData();
      _setStatus(SecureStorageStatus.wiped);
    } catch (e) {
      _errorMessage = e.toString();
      _setStatus(SecureStorageStatus.error);
    }
  }

  // ─── Helpers ─────────────────────────────────────────────────────────────

  void _setStatus(SecureStorageStatus s) {
    _status = s;
    notifyListeners();
  }
}