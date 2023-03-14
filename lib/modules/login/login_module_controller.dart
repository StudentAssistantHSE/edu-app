part of 'login_module.dart';

abstract class LoginModuleController extends BaseModuleController {
  const LoginModuleController();

  void onSuccessLogin(BuildContext context, String token);
  void onOpenRegistration();
}