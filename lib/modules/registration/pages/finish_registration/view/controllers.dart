import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_ui_components/edu_ui_components.dart';

class PageTitleTextController extends TextController {
  const PageTitleTextController();

  @override
  String textSelector(S translations) => translations.registration_finishRegistration_pageTitle;
}

class PageSubtitleTextController extends TextController {
  const PageSubtitleTextController();

  @override
  String textSelector(S translations) => translations.registration_finishRegistration_pageSubtitle;
}