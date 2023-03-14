import 'dart:io';

import 'package:tools/deploy_ios/deploy_ios.dart';

Future<void> main(List<String> arguments) async {
  if (arguments.length != 2) {
    stderr.writeln('Usage: "dart run deploy_uis.dart <test/dev/production> <obfuscate: true/false>"');
    exit(-1);
  }

  final environment = arguments.first;
  final obfuscate = arguments[1];

  final result = await IosDeployer.deploy(environment, obfuscate);
  if (result != null) {
    stderr.writeln(result);
    exit(-1);
  }

  stdout.writeln('Successfully deployed with $environment environment and obfuscating set to $obfuscate!');
}
