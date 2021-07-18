import '../../domain/user.dart';
import '../dto/user.dart';

extension ConvertibleUserDto on UserDto {
  User get asEntity => User(
        id: id,
        name: name,
        username: username,
      );
}
