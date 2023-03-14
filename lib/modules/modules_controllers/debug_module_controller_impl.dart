import 'package:edu_app/di/locator.dart';
import 'package:edu_app/modules/debug/debug_module.dart';
import 'package:edu_app/modules/modules_routes.dart';
import 'package:feature_authentication/feature_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebugModuleControllerImpl extends DebugModuleController {
  const DebugModuleControllerImpl();

  @override
  void onLogout(BuildContext context) {
    context.read<AuthenticationBloc>().add(const AuthenticationLoggedOut());
    locator.app.navigation.pushNamedAndRemoveUntil(
      ModulesRoutes.login,
      (route) => false,
    );
  }
}