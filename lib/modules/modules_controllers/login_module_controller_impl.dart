import 'package:edu_app/di/locator.dart';
import 'package:edu_app/modules/login/login_module.dart';
import 'package:edu_app/modules/modules_routes.dart';
import 'package:feature_authentication/feature_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginModuleControllerImpl extends LoginModuleController {
  const LoginModuleControllerImpl();

  @override
  void onSuccessLogin(BuildContext context, String token) {
    context.read<AuthenticationBloc>().add(AuthenticationLoggedIn(token));
    locator.app.navigation
        .pushNamedAndRemoveUntil(ModulesRoutes.root, (route) => false);
  }

  @override
  void onOpenRegistration() => locator.app.navigation
      .pushNamed(ModulesRoutes.registration);
}