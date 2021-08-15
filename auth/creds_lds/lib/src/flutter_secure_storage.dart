import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2/oauth2.dart';

import 'interface.dart';

/// A
/// {@template creds_lds_flutter_secure_storage}
/// credentials local data source implementation
/// {@endtemplate}
///  that uses [FlutterSecureStorage].
class CredsLDSImp extends CredsLDS {
  /// Creates a
  /// {@macro creds_lds_flutter_secure_storage}
  /// with the given [flutterSecureStorage].
  CredsLDSImp({
    required FlutterSecureStorage flutterSecureStorage,
  }) : _flutterSecureStorage = flutterSecureStorage;

  /// The [FlutterSecureStorage] to store credentials.
  final FlutterSecureStorage _flutterSecureStorage;

  /// The key to store credentials with.
  @visibleForTesting
  static const credsKey = 'creds';

  /// The cached stored credentials.
  @visibleForTesting
  Credentials? creds;

  @override
  Future<void> clear() async {
    // Removes the credentials from the secure storage.
    await _flutterSecureStorage.delete(
      key: credsKey,
    );
    // Removes the in-memory-cached credentials.
    creds = null;
  }

  @override
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

  @override
  Future<Credentials?> get() async {
    // Returns the cached credentials if they exist.
    if (creds != null) return creds;

    // Reads the stored serialized credentials.
    final credsJson = await _flutterSecureStorage.read(
      key: credsKey,
    );

    // Returns the deserialized credentials if they exist.
    if (credsJson == null) return null;
    return creds = Credentials.fromJson(
      credsJson,
    );
  }
}
