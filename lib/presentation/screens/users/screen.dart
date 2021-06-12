import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/cubit/users/users_cubit.dart';
import '../../../l10n/l10n.dart';
import '../../widgets/drawer.dart';
import 'widgets/user_tile.dart';
import 'widgets/wrapper.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Wrapper(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(l10n.usersScreenTitle),
        ),
        drawer: const AppDrawer(),
        body: BlocBuilder<UsersCubit, UsersState>(
          builder: (context, usersState) => usersState.maybeWhen(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (users) => users.isEmpty()
                ? Center(
                    child: Text(l10n.noUsersMessage),
                  )
                : ListView(
                    children: [
                      ...users.iter.map(
                        (user) => UserTile(
                          key: ValueKey(user.id),
                          user: user,
                        ),
                      ),
                    ],
                  ),
            orElse: () => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
