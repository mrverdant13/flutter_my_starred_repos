import 'package:flutter/material.dart';

import '../../../../domain/entities/user.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(user.name),
        subtitle: Text(user.username),
      );
}
