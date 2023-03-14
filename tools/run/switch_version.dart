import 'dart:io';

import 'package:tools/switch_version/switch_version.dart';

Future<void> main(List<String> arguments) async {
  if (arguments.length != 1) {
    stderr.writeln('Usage: "dart run switch_version.dart <version (format: vX.X.X>"');
    exit(-1);
  }

  final target = arguments.first;
  final result = await VersionSwitcher.switchTo(target);
  if (result != null) {
    stderr.writeln(result);
    exit(-1);
  }

  stdout.writeln('Version successfully switched to $target!');
}
