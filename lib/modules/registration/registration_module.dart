import 'package:edu_app/modules/registration/pages/finish_registration/finish_registration_page.dart';
import 'package:edu_app/modules/registration/pages/registration/registration_page.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';

part 'registration_module_arguments.dart';
part 'registration_module_controller.dart';
part 'registration_module_routing.dart';

class RegistrationModule extends BaseModule<
  RegistrationModuleArguments,
  RegistrationModuleRouting,
  RegistrationModuleController
> {
  RegistrationModule({
    ControllerBuilder<RegistrationModuleController>? controllerBuilder,
    Key? key,
  }) : super(
    useWillPopScope: (controller) => controller?.useWillPopScope,
    moduleControllerBuilder: controllerBuilder,
    moduleRouting: const RegistrationModuleRouting(),
    key: key,
  );
}