import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class _Keys {
  static const nameCompany      = 'vivia_nameCompany';
  static const fullName   = 'vivia_fullName';
  static const email        = 'vivia_email';
  static const password = 'vivia_password';

  static const all = [nameCompany, fullName, email, password];
}

class SecureStorageDataSource {
  final FlutterSecureStorage _storage;

  SecureStorageDataSource({FlutterSecureStorage? storage})
      : _storage = storage ??
      const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );

  // ─── Write ───────────────────────────────────────────────────────────────

  Future<void> saveNameCompany(String value) =>
      _storage.write(key: _Keys.nameCompany, value: value);

  Future<void> saveFullName(String value) =>
      _storage.write(key: _Keys.fullName, value: value);

  Future<void> saveEmail(String value) =>
      _storage.write(key: _Keys.email, value: value);

  Future<void> savePassword(String value) =>
      _storage.write(key: _Keys.password, value: value);

  // ─── Read ────────────────────────────────────────────────────────────────

  Future<String?> readCompanyName() =>
      _storage.read(key: _Keys.nameCompany);

  Future<String?> readFullName() =>
      _storage.read(key: _Keys.fullName);

  Future<String?> readEmail() =>
      _storage.read(key: _Keys.email);

  Future<String?> readPassword() =>
      _storage.read(key: _Keys.password);

  // ─── Wipe ────────────────────────────────────────────────────────────────

  /// Elimina únicamente las claves sensibles definidas en [_Keys.all].
  /// No borra datos de otros features para no afectar el resto de la app.
  Future<void> deleteAllSensitiveData() async {
    await Future.wait(
      _Keys.all.map((key) => _storage.delete(key: key)),
    );
  }
}