import 'dart:io';

import 'package:tools/deploy_ios/environment.dart';
import 'package:tools/switch_secrets/secrets_switcher.dart';
import 'package:tools/utils/utils.dart';

abstract class IosDeployer {
  const IosDeployer._();

  static Future<String?> deploy(String environment, String obfuscate) async {
    final convertedEnvironment = EnvironmentConverter.fromString(environment);
    if (convertedEnvironment == null) {
      return 'Undefined target "$environment", available environments: "test", "dev", "production"';
    }

    final bool convertedObfuscation;
    switch (obfuscate.toLowerCase()) {
      case 'true':
        convertedObfuscation = true;
        break;
      case 'false':
        convertedObfuscation = false;
        break;
      default:
        return 'Obfuscate parameter is required and should be true or false';
    }

    final projectDirectory = await Git.getProjectDirectory();
    if (projectDirectory == null) {
      return "Can't detect git root directory, seems like script is moved outside repository";
    }

    final switchSecretsResult = await SecretsSwitcher.switchTo(convertedEnvironment.asString);
    if (switchSecretsResult != null) {
      return switchSecretsResult;
    }
    stdout.writeln('Successfully set secrets for ${convertedEnvironment.asString}!');

    final buildProcess = await Process.run(
      'flutter',
      [
        'build',
        'ipa',
        if (convertedObfuscation)
          '--obfuscate',
        if (convertedObfuscation)
          '--split-debug-info=$projectDirectory/debug_info',
        '--flavor',
        convertedEnvironment.asString,
      ],
      runInShell: true,
      workingDirectory: projectDirectory,
    );

    if (buildProcess.exitCode == 0) {
      return null;
    }

    stderr
      ..writeln(buildProcess.stderr.toString())
      ..writeln();
    return 'Error while deploying with $environment and obfuscation set to $obfuscate';
  }
}