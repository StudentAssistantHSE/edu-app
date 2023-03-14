import 'package:edu_services/edu_services.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ServicesModule {
  @lazySingleton
  @preResolve
  Future<PreferencesStorageService> get preferencesStorageService =>
      PreferencesStorageService.create();

  @lazySingleton
  SecureStorageService get secureStorageService => const SecureStorageService();

  @lazySingleton
  ExternalNetworkService get externalNetworkService => ExternalNetworkService();

  const ServicesModule();

  @lazySingleton
  ApiNetworkService apiNetworkService() => ApiNetworkService();
}