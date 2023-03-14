import 'package:edu_app/common/common.dart';
import 'package:edu_localizations/edu_localizations.dart';

class PageTitleTextController extends TextStateController {
  const PageTitleTextController();

  @override
  String textSelector(S translations) => translations.registration_finishRegistration_pageTitle;
}

class PageSubtitleTextController extends TextStateController {
  const PageSubtitleTextController();

  @override
  String textSelector(S translations) => translations.registration_finishRegistration_pageSubtitle;
}