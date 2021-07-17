import '../../domain/user.dart';
import '../dtos/user.dart';

extension ConvertibleUserDto on UserDto {
  User get asEntity => User(
        username: username,
        avatarUrl: avatarUrl,
      );
}
