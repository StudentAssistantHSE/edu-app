import 'dart:io';

import 'package:tools/switch_deps/switch_deps.dart';

Future<void> main(List<String> arguments) async {
  if (arguments.length != 1) {
    stderr.writeln('Usage: "dart run switch_deps.dart <local/git>"');
    exit(-1);
  }

  final target = arguments.first;
  final result = await DependenciesSwitcher.switchTo(target);
  if (result != null) {
    stderr.writeln(result);
    exit(-1);
  }

  stdout.writeln('Dependencies successfully switched to $target!');
}
