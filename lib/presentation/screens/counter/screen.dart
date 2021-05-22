import 'package:flutter/material.dart';

import '../../../core/flavors.dart';
import '../../../l10n/l10n.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen();

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  void _incrementCounter() => setState(
        () {
          _counter++;
        },
      );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.counterScreenTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/app_icon/${kAppFlavor.tag.toLowerCase()}-icon.512.png',
              ),
            ),
            Text(
              '${kAppFlavor.tag} flavor',
            ),
            Text(l10n.currentCountMessage),
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
