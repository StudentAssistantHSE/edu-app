part of 'registration_module.dart';

abstract class RegistrationModuleController extends BaseModuleController {
  final ValueNotifier<bool> useWillPopScope = ValueNotifier<bool>(false);

  RegistrationModuleController();

  void onSuccessRegistration(BuildContext context, String token);
}