import 'package:oauth2/oauth2.dart';

/// A credentials storage interface.
abstract class CredsStorage {
  /// Creates a credentials storage interface.
  const CredsStorage();

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
