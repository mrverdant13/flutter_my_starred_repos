import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.usersScreenTitle),
      ),
    );
  }
}
