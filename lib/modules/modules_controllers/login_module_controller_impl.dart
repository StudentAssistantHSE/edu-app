import 'package:edu_app/di/locator.dart';
import 'package:edu_app/modules/login/login_module.dart';
import 'package:edu_app/modules/modules_routes.dart';

class LoginModuleControllerImpl extends LoginModuleController {
  const LoginModuleControllerImpl();

  @override
  void onOpenRegistration() => locator.app.navigation
      .pushNamed(ModulesRoutes.registration);
}