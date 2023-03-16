// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:edu_app/di/modules/app_module.dart' as _i11;
import 'package:edu_app/di/modules/repositories_module.dart' as _i10;
import 'package:edu_app/di/modules/services_module.dart' as _i9;
import 'package:edu_core/edu_core.dart' as _i4;
import 'package:edu_repositories/edu_repositories.dart' as _i6;
import 'package:edu_services/edu_services.dart' as _i3;
import 'package:edu_ui_components/edu_ui_components.dart' as _i5;
import 'package:feature_authentication/feature_authentication.dart' as _i8;
import 'package:feature_settings/feature_settings.dart' as _i7;
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
    final servicesModule = _$ServicesModule();
    final appModule = _$AppModule();
    final repositoriesModule = _$RepositoriesModule();
    gh.lazySingleton<_i3.ApiNetworkService>(
        () => servicesModule.apiNetworkService());
    gh.factory<_i4.Env>(() => appModule.env);
    gh.lazySingleton<_i3.ExternalNetworkService>(
        () => servicesModule.externalNetworkService);
    gh.lazySingleton<_i5.Navigation>(() => appModule.navigation);
    gh.factoryParam<_i6.NetworkRepository, String?, dynamic>((
      token,
      _,
    ) =>
        repositoriesModule.networkRepository(
          gh<_i4.Env>(),
          gh<_i3.ApiNetworkService>(),
          gh<_i3.ExternalNetworkService>(),
          token,
        ));
    await gh.lazySingletonAsync<_i3.PreferencesStorageService>(
      () => servicesModule.preferencesStorageService,
      preResolve: true,
    );
    gh.lazySingleton<_i3.SecureStorageService>(
        () => servicesModule.secureStorageService);
    await gh.lazySingletonAsync<_i7.SettingsRepository>(
      () => repositoriesModule
          .settingsRepository(gh<_i3.PreferencesStorageService>()),
      preResolve: true,
    );
    await gh.lazySingletonAsync<_i8.AuthenticationRepository>(
      () => repositoriesModule
          .authenticationRepository(gh<_i3.SecureStorageService>()),
      preResolve: true,
    );
    return this;
  }
}

class _$ServicesModule extends _i9.ServicesModule {}

class _$RepositoriesModule extends _i10.RepositoriesModule {}

class _$AppModule extends _i11.AppModule {}
