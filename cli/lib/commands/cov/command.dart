import 'dart:io';

import 'package:args/command_runner.dart';

import 'commands/merge.dart';

Future<void> run(List<String> args) async {
  try {
    final runner = CommandRunner(
      'cov',
      'A set of handy commands to manipulate `lcov.info` files.',
    );

    runner.addCommand(MergeCommand());

    await runner.run(args);
  } catch (e) {
    stdout.write('$e');
    exitCode = 1;
  }
}
