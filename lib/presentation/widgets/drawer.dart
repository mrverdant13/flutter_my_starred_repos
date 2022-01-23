import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_starred_repos/features/auth/core/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../routers/app_router.gr.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => Drawer(
        child: ListView(
          children: <Widget>[
            // TODO: Add translations.
            const DrawerHeader(
              child: Text('Examples'),
            ),
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.plus_one),
                  title: const Text('Counter'),
                  onTap: () async => context.router.push(
                    const CounterScreenRoute(),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.groups),
                  title: const Text('Users'),
                  onTap: () async => context.router.push(
                    const UsersScreenRoute(),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.star_border),
                  title: const Text('Starred Repos'),
                  onTap: () async => context.router.push(
                    const StarredReposScreenRoute(),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Log out'),
                  onTap: () => ref.watch(authCubitPod).logOut(),
                ),
              ],
            ),
          ],
        ),
      );
}
