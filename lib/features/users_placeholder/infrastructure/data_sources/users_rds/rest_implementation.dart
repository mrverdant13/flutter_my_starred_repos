import 'dart:io';

import 'package:dio/dio.dart';

import '../../dto/user.dart';
import 'interface.dart';

class UsersRDSImp extends UsersRDS {
  const UsersRDSImp({
    required this.dio,
  });

  final Dio dio;

  @override
  Future<List<UserDto>> getUsers() async {
    // API endpoint doc:
    // https://jsonplaceholder.typicode.com/

    late final Response response;

    try {
      response = await dio.get(
        '/users',
      );
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.other:
          if (e.error != null && e.error is SocketException) {
            throw const GetUsersException.offline();
          }
          break;
        default:
          rethrow;
      }
    }

    final jsonUsers = response.data as List;

    final users = jsonUsers
        .map(
          (jsonUser) => UserDto.fromJson(
            jsonUser as Map<String, dynamic>,
          ),
        )
        .toList();

    return users;
  }
}
