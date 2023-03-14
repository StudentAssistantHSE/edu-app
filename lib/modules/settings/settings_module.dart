import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';

part 'settings_module_arguments.dart';
part 'settings_module_controller.dart';
part 'settings_module_routing.dart';

class SettingsModule extends BaseModule<SettingsModuleArguments, SettingsModuleRouting, SettingsModuleController> {
  const SettingsModule({
    ControllerBuilder<SettingsModuleController>? controllerBuilder,
    Key? key,
  }) : super(
    moduleControllerBuilder: controllerBuilder,
    moduleRouting: const SettingsModuleRouting(),
    key: key,
  );
}