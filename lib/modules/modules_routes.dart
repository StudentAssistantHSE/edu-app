import 'package:edu_app/modules/categories/categories_module.dart';
import 'package:edu_app/modules/debug/debug_module.dart';
import 'package:edu_app/modules/login/login_module.dart';
import 'package:edu_app/modules/modules_controllers/categories_module_controller_impl.dart';
import 'package:edu_app/modules/modules_controllers/login_module_controller_impl.dart';
import 'package:edu_app/modules/modules_controllers/profile_editing_module_controller_impl.dart';
import 'package:edu_app/modules/modules_controllers/root_module_controller_impl.dart';
import 'package:edu_app/modules/profile_editing/profile_editing_module.dart';
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
  static const profileEditing = 'profile-editing';
  static const categories = 'categories';

  static const _moduleName = 'top-level module';

  static final RoutesTable _table = {
    ModulesRoutes.debug: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => const DebugModule(),
    ),
    ModulesRoutes.login: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => LoginModule(
        controllerBuilder: (_) => const LoginModuleControllerImpl(),
      ),
    ),
    ModulesRoutes.registration: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => const RegistrationModule(),
    ),
    ModulesRoutes.root: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => RootModule(controllerBuilder: (context) => const RootModuleControllerImpl()),
    ),
    ModulesRoutes.profileEditing: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => ProfileEditingModule(controllerBuilder: (context) => const ProfileEditingModuleControllerImpl()),
    ),
    ModulesRoutes.categories: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => CategoriesModule(controllerBuilder: (context) => const CategoriesModuleControllerImpl()),
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