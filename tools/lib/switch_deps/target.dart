import 'package:tools/utils/utils.dart';

enum Target {
  local,
  git,
}

extension TargetConverter on Target {
  String get asString {
    switch (this) {
      case Target.local:
        return 'local';
      case Target.git:
        return 'git';
    }
  }

  String get asPubspecFile => '${asString}_${Paths.pubspecFileName}';

  static Target? fromString(String target) {
    switch (target.toLowerCase()) {
      case 'local':
        return Target.local;
      case 'git':
        return Target.git;
      default:
        return null;
    }
  }
}