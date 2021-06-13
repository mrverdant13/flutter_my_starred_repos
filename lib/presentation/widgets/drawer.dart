import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../routers/app_router.gr.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // TODO: Add translations.
              const Text('Examples'),
              ElevatedButton(
                onPressed: () => context.router.push(
                  const CounterScreenRoute(),
                ),
                child: const Text('Counter'),
              ),
              ElevatedButton(
                onPressed: () => context.router.push(
                  const UsersScreenRoute(),
                ),
                child: const Text('Users'),
              ),
            ],
          ),
        ),
      );
}
