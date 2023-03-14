import 'package:edu_app/modules/debug/debug_module.dart';
import 'package:edu_app/modules/login/login_module.dart';
import 'package:edu_app/modules/modules_controllers/debug_module_controller_impl.dart';
import 'package:edu_app/modules/modules_controllers/login_module_controller_impl.dart';
import 'package:edu_app/modules/modules_controllers/registration_module_controller_impl.dart';
import 'package:edu_app/modules/modules_controllers/root_module_controller_impl.dart';
import 'package:edu_app/modules/registration/registration_module.dart';
import 'package:edu_app/modules/root/root_module.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_authentication/feature_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ModulesRoutes {
  static const debug = 'debug';
  static const login = 'login';
  static const registration = 'registration';
  static const root = 'root';

  static const _moduleName = 'top-level module';

  static final RoutesTable _table = {
    ModulesRoutes.debug: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => DebugModule(
        controllerBuilder: (_) => const DebugModuleControllerImpl(),
      ),
    ),
    ModulesRoutes.login: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => LoginModule(
        controllerBuilder: (_) => const LoginModuleControllerImpl(),
      ),
    ),
    ModulesRoutes.registration: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => RegistrationModule(
        controllerBuilder: (_) => RegistrationModuleControllerImpl(),
      ),
    ),
    ModulesRoutes.root: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => RootModule(
        controllerBuilder: (_) => const RootModuleControllerImpl(),
      ),
    ),
  };

  const ModulesRoutes._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final routeBuilder = _table[settings.name];
    if (routeBuilder == null) {
      throw NoRouteException(route: settings.name, moduleName: _moduleName);
    }

    return routeBuilder(settings);
  }

  static String initialRouteBuilder(BuildContext context) {
    final state = context.read<AuthenticationBloc>().state;
    return [
      if (state.isAuthenticated)
        ModulesRoutes.root
      else
        ModulesRoutes.login,
    ].join('/');
  }
}