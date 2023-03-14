import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/cupertino.dart';

abstract class ErrorViewController {
  ErrorImageType get type;

  const ErrorViewController();

  String titleSelector(S translations);
  String? subtitleSelector(S translations);
  String tryAgainButtonTextSelector(S translations);

  void onTryAgainButtonTap(BuildContext context);
}