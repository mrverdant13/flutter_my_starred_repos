import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2/oauth2.dart';

class CredsStorage {
  CredsStorage({
    required FlutterSecureStorage flutterSecureStorage,
  }) : _flutterSecureStorage = flutterSecureStorage;

  final FlutterSecureStorage _flutterSecureStorage;

  @visibleForTesting
  static const credsKey = 'creds';

  @visibleForTesting
  Credentials? creds;

  Future<void> clear() async {
    // Removes the credentials from the secure storage.
    await _flutterSecureStorage.delete(key: credsKey);
    // Removes the in-memory-cached credentials.
    creds = null;
  }

  Future<void> set(
    Credentials credentials,
  ) async {
    // Stores the given credentials after their serialization.
    await _flutterSecureStorage.write(
      key: credsKey,
      value: credentials.toJson(),
    );
    // Chaches the credentials in memory.
    creds = credentials;
  }

  Future<Credentials?> get() async {
    // Returns the cached credentials if they exist.
    if (creds != null) return creds;

    // Reads the stored serialized credentials.
    final credsJson = await _flutterSecureStorage.read(key: credsKey);

    // Returns the deserialized credentials if they exist.
    if (credsJson == null) return null;
    return creds = Credentials.fromJson(credsJson);
  }
}
