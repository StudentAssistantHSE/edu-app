import 'package:edu_app/secrets.dart';

abstract class Settings {
  static const String apiAddress = SECRET_API_ADDRESS;
  static const String sentryUrl = SECRET_SENTRY_URL;
  static const String version = 'edu-app@0.0.1';
  static const String shareUrl = SECRET_SHARE_URL;

  const Settings._();
}