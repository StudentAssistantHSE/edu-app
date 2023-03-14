import 'dart:io';

import 'package:tools/switch_deps/target.dart';
import 'package:tools/utils/utils.dart';

abstract class DependenciesSwitcher {
  const DependenciesSwitcher._();

  static Future<String?> switchTo(String target) async {
    final convertedTarget = TargetConverter.fromString(target);
    if (convertedTarget == null) {
      return 'Undefined target "$target", available targets: "local", "git"';
    }

    final projectDirectory = await Git.getProjectDirectory();
    if (projectDirectory == null) {
      return "Can't detect git root directory, seems like script is moved outside repository";
    }
    final projectPubspecFile = File('$projectDirectory/${Paths.pubspecFileName}');
    final projectPubspecFileDirectory = projectPubspecFile.parent.path;
    final toolsPubspecFile = File('$projectDirectory/${Paths.toolsProjectDirectory}/${Paths.pubspecFileName}');
    final toolsPubspecFileDirectory = toolsPubspecFile.parent.path;

    final targetPubspecFile = convertedTarget.asPubspecFile;

    final targetProjectFilePath = '$projectPubspecFileDirectory/$targetPubspecFile';
    final targetToolsFilePath = '$toolsPubspecFileDirectory/$targetPubspecFile';

    for (final files in [[File(targetProjectFilePath), projectPubspecFile], [File(targetToolsFilePath), toolsPubspecFile]]) {
      if (Paths.fileExists(targetProjectFilePath)) {
        final result = await Paths.replaceFilesContent(files.first, files.last);
        if (result != null) {
          return result;
        }
      } else {
        return "Error: can't find $targetPubspecFile in ${files.last.parent.path}";
      }
    }


    return null;
  }
}