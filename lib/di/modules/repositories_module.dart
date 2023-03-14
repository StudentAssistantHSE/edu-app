import 'package:edu_core/edu_core.dart';
import 'package:edu_repositories/edu_repositories.dart';
import 'package:edu_services/edu_services.dart';
import 'package:feature_authentication/feature_authentication.dart';
import 'package:feature_settings/feature_settings.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RepositoriesModule {
  const RepositoriesModule();

  @lazySingleton
  @preResolve
  Future<AuthenticationRepository> authenticationRepository(
    SecureStorageService secureStorageService,
  ) => AuthenticationRepository.create(secureStorageService);

  @injectable
  NetworkRepository networkRepository(
    Env environment,
    ApiNetworkService apiNetworkService,
    ExternalNetworkService externalNetworkService,
    @factoryParam String? token,
  ) => NetworkRepository(
    token,
    environment,
    apiNetworkService,
    externalNetworkService,
  );

  @lazySingleton
  @preResolve
  Future<SettingsRepository> settingsRepository(
    PreferencesStorageService preferencesStorageService,
  ) => SettingsRepository.create(preferencesStorageService);
}
