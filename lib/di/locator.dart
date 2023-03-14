import 'package:edu_app/di/injector.dart';
import 'package:edu_repositories/edu_repositories.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_authentication/feature_authentication.dart';
import 'package:feature_settings/feature_settings.dart';
import 'package:get_it/get_it.dart' as get_it;

const locator = Locator();

class _AppLocator {
  Navigation get navigation => _getIt<Navigation>();

  get_it.GetIt get _getIt => getIt;

  const _AppLocator();
}

class _RepositoriesLocator {
  AuthenticationRepository get authentication => _getIt<AuthenticationRepository>();
  SettingsRepository get settings => _getIt<SettingsRepository>();

  get_it.GetIt get _getIt => getIt;

  const _RepositoriesLocator();

  NetworkRepository networkRepository(String? user) => _getIt<NetworkRepository>(param1: user);
}

class Locator {
  static const _app = _AppLocator();
  static const _repositories = _RepositoriesLocator();

  _AppLocator get app => _app;
  _RepositoriesLocator get repositories => _repositories;

  const Locator();
}