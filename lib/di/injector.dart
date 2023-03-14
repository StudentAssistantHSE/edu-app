import 'package:edu_app/di/injector.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  preferRelativeImports: false,
)
Future<void> configureDependencies() => getIt.init();