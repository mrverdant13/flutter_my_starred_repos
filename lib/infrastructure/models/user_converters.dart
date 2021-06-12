part of 'user.dart';

extension ConvertibleUserR on UserR {
  User get asEntity => User(
        id: id,
        name: name,
        username: username,
      );
}
