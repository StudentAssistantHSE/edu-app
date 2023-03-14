// ignore_for_file: avoid_redundant_argument_values

import 'package:edu_app/settings.dart';
import 'package:edu_core/edu_core.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @injectable
  Env get env => const Env(
    version: Settings.version,
    apiAddress: Settings.apiAddress,
    shareUrl: Settings.shareUrl,
    sentryUrl: Settings.sentryUrl,
  );

  @lazySingleton
  Navigation get navigation => Navigation();

  const AppModule();
}