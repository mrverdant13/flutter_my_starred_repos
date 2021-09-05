import 'package:oauth2/oauth2.dart';

/// A
/// {@template creds_lds}
/// credentials local data source.
/// {@endtemplate}
abstract class CredsLDS {
  /// Creates a
  /// {@macro creds_lds}
  const CredsLDS();

  /// Returns the stored credentials.
  Future<Credentials?> get();

  /// Deletes the stored credentials.
  Future<void> clear();

  /// Stores the given [credentials].
  ///
  /// If another credentials have been previously stored, they get overwritten.
  Future<void> set(
    Credentials credentials,
  );
}
