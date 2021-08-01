import 'package:flutter/material.dart';
import 'package:flutter_my_starred_repos/core/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/flavors.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../presentation/widgets/drawer.dart';

class CounterScreen extends ConsumerStatefulWidget {
  const CounterScreen();

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends ConsumerState<CounterScreen> {
  int _counter = 0;

  void _incrementCounter() => setState(
        () {
          _counter++;
        },
      );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final flavor = ref.watch(flavorPod);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.counterScreenTitle),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/app_icon/${flavor.tag.toLowerCase()}-icon.512.png',
              ),
            ),
            Text(
              '${flavor.tag} flavor',
            ),
            Text(l10n.currentCountMessage(_counter)),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: l10n.increaserButtonTooltip,
        child: const Icon(Icons.add),
      ),
    );
  }
}
