part of 'login_module.dart';

class LoginModuleRouting extends BaseModuleRouting<LoginModuleArguments> {
  static const login = 'login';

  static const moduleName = 'login';

  static final RoutesTable _table = {
    LoginModuleRouting.login: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => LoginPage(),
    ),
  };

  @override
  RoutesTable get table => _table;

  const LoginModuleRouting() : super(moduleName);

  @override
  String? initialRouteBuilder(LoginModuleArguments? moduleArguments) =>
      [
        LoginModuleRouting.login,
      ].join('/');
}