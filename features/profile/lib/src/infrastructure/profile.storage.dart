import 'package:flutter/foundation.dart';
import 'package:profile/src/domain/profile.entity.dart';
import 'package:sembast/sembast.dart';

class ProfileStorage {
  ProfileStorage({
    required Database sembastDatabase,
  })  : _db = sembastDatabase,
        store = StoreRef(storeName);

  final Database _db;

  @visibleForTesting
  final StoreRef<String, Map<String, dynamic>> store;

  @visibleForTesting
  RecordRef<String, Map<String, dynamic>> get record => store.record(storeKey);

  @visibleForTesting
  static const storeName = 'profile';

  @visibleForTesting
  static const storeKey = 'profile';

  Future<void> setProfile(
    Profile profile,
  ) async =>
      record.put(_db, profile.toJson());

  Future<Profile> get profile async {
    final jsonProfile = await record.get(_db);
    return Profile.fromJson(jsonProfile!);
  }

  Stream<Profile> watchProfile() =>
      record.onSnapshot(_db).map((event) => Profile.fromJson(event!.value));
}
