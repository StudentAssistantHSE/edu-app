part of 'registration_module.dart';

class RegistrationModuleRouting extends BaseModuleRouting<RegistrationModuleArguments> {
  static const registration = 'registration';
  static const finishRegistration = 'finish-registration';

  static const moduleName = 'registration';

  static final RoutesTable _table = {
    RegistrationModuleRouting.registration: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => RegistrationPage(),
    ),
    RegistrationModuleRouting.finishRegistration: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => const FinishRegistrationPage(),
    ),
  };

  @override
  RoutesTable get table => _table;

  const RegistrationModuleRouting() : super(moduleName);

  @override
  String? initialRouteBuilder(RegistrationModuleArguments? moduleArguments) =>
      RegistrationModuleRouting.registration;
}