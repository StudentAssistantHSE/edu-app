import 'package:edu_localizations/edu_localizations.dart';

abstract class TextStateController {
  const TextStateController();

  String textSelector(S translations);
}