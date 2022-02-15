import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_starred_repos/features/auth/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/presentation/routers/app_router.gr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
