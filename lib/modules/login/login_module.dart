import 'package:edu_app/modules/login/pages/login/login_page.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';

part 'login_module_arguments.dart';
part 'login_module_controller.dart';
part 'login_module_routing.dart';

class LoginModule extends BaseModule<
  LoginModuleArguments,
  LoginModuleRouting,
  LoginModuleController
> {
  const LoginModule({
    ControllerBuilder<LoginModuleController>? controllerBuilder,
    Key? key,
  }) : super(
    moduleControllerBuilder: controllerBuilder,
    moduleRouting: const LoginModuleRouting(),
    key: key,
  );
}