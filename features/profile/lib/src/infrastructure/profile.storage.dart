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
  static const storeName = 'profile';

  @visibleForTesting
  static const storeKey = 'profile';

  Future<void> setProfile(
    Profile profile,
  ) async =>
      store.record(storeKey).put(_db, profile.toJson());

  Future<Profile> get profile async {
    final jsonProfile = await store.record(storeKey).get(_db);
    return Profile.fromJson(jsonProfile!);
  }

  Stream<Profile> watchProfile() async* {
    yield await profile;
    yield* store
        .query(finder: Finder(filter: Filter.byKey(storeKey)))
        .onSnapshot(_db)
        .map((event) => Profile.fromJson(event!.value));
  }
}
