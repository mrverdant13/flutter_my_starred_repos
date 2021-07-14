import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2/oauth2.dart';

import 'interface.dart';

/// A credentials storage implementation that uses [FlutterSecureStorage].
class CredsStorageImp extends CredsStorage {
  /// Creates a credentials storage implementation with the given
  /// [flutterSecureStorage].
  CredsStorageImp({
    required FlutterSecureStorage flutterSecureStorage,
  }) : _flutterSecureStorage = flutterSecureStorage;

  /// The [FlutterSecureStorage] to store credentials.
  final FlutterSecureStorage _flutterSecureStorage;

  /// The key to store credentials with.
  static const _credsKey = 'creds';

  /// The cached stored credentials.
  Credentials? _creds;

  @override
  Future<void> clear() async {
    // Removes the credentials from the secure storage.
    await _flutterSecureStorage.delete(
      key: _credsKey,
    );
    // Removes the in-memory-cached credentials.
    _creds = null;
  }

  @override
  Future<void> set(
    Credentials credentials,
  ) async {
    // Stores the given credentials after their serialization.
    await _flutterSecureStorage.write(
      key: _credsKey,
      value: credentials.toJson(),
    );
    // Chaches the credentials in memory.
    _creds = credentials;
  }

  @override
  Future<Credentials?> get() async {
    // Returns the cached credentials if they exist.
    if (_creds != null) return _creds;

    // Reads the stored serialized credentials.
    final credsJson = await _flutterSecureStorage.read(
      key: _credsKey,
    );

    // Returns the deserialized credentials if they exist.
    if (credsJson == null) return null;
    return Credentials.fromJson(
      credsJson,
    );
  }
}
