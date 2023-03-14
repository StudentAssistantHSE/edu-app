// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:edu_app/di/modules/app_module.dart' as _i10;
import 'package:edu_app/di/modules/repositories_module.dart' as _i9;
import 'package:edu_app/di/modules/services_module.dart' as _i8;
import 'package:edu_core/edu_core.dart' as _i3;
import 'package:edu_repositories/edu_repositories.dart' as _i7;
import 'package:edu_services/edu_services.dart' as _i4;
import 'package:edu_ui_components/edu_ui_components.dart' as _i5;
import 'package:feature_settings/feature_settings.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart'
    as _i2; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    final servicesModule = _$ServicesModule();
    final repositoriesModule = _$RepositoriesModule();
    gh.factory<_i3.Env>(() => appModule.env);
    gh.lazySingleton<_i4.ExternalNetworkService>(
        () => servicesModule.externalNetworkService);
    gh.lazySingleton<_i4.LocationService>(() => servicesModule.locationService);
    gh.lazySingleton<_i5.Navigation>(() => appModule.navigation);
    await gh.lazySingletonAsync<_i4.PreferencesStorageService>(
      () => servicesModule.preferencesStorageService,
      preResolve: true,
    );
    gh.lazySingleton<_i4.SecureStorageService>(
        () => servicesModule.secureStorageService);
    await gh.lazySingletonAsync<_i6.SettingsRepository>(
      () => repositoriesModule
          .settingsRepository(gh<_i4.PreferencesStorageService>()),
      preResolve: true,
    );
    gh.lazySingleton<_i7.StorageRepository>(
        () => repositoriesModule.storageRepository(
              gh<_i4.PreferencesStorageService>(),
              gh<_i4.SecureStorageService>(),
            ));
    await gh.lazySingletonAsync<_i4.ApiNetworkService>(
      () => servicesModule.apiNetworkService(gh<_i3.Env>()),
      preResolve: true,
    );
    await gh.lazySingletonAsync<_i7.AuthenticationStorage>(
      () => repositoriesModule
          .authenticationStorage(gh<_i4.SecureStorageService>()),
      preResolve: true,
    );
    await gh.lazySingletonAsync<_i7.CookiesStorage>(
      () => repositoriesModule.cookiesStorage(gh<_i4.SecureStorageService>()),
      preResolve: true,
    );
    gh.lazySingleton<_i7.LocationRepository>(
        () => repositoriesModule.locationRepository(gh<_i4.LocationService>()));
    gh.factoryParam<_i7.NetworkRepository, String?, dynamic>((
      user,
      _,
    ) =>
        repositoriesModule.networkRepository(
          gh<_i7.CookiesStorage>(),
          gh<_i3.Env>(),
          gh<_i4.ApiNetworkService>(),
          gh<_i4.ExternalNetworkService>(),
          user,
        ));
    await gh.lazySingletonAsync<_i7.AuthenticationRepository>(
      () => repositoriesModule.authenticationRepository(
        gh<_i7.AuthenticationStorage>(),
        gh<_i4.SecureStorageService>(),
      ),
      preResolve: true,
    );
    return this;
  }
}

class _$ServicesModule extends _i8.ServicesModule {}

class _$RepositoriesModule extends _i9.RepositoriesModule {}

class _$AppModule extends _i10.AppModule {}
