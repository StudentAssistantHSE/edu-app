import 'package:edu_app/common/views/error/error_view_controller.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_ui_components/edu_ui_components.dart';

class ErrorTitleController extends TextController {
  final ErrorViewController controller;

  const ErrorTitleController(this.controller);

  @override
  String textSelector(S translations) => controller.titleSelector(translations);
}

class ErrorSubtitleController extends TextController {
  final ErrorViewController controller;

  const ErrorSubtitleController(this.controller);

  @override
  String? textSelector(S translations) => controller.subtitleSelector(translations);
}