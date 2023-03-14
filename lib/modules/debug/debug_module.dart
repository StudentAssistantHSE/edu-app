import 'package:edu_app/modules/debug/pages/debug/debug_page.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';

part 'debug_module_arguments.dart';
part 'debug_module_controller.dart';
part 'debug_module_routing.dart';

class DebugModule extends BaseModule<DebugModuleArguments, DebugModuleRouting, DebugModuleController> {
  const DebugModule({
    ControllerBuilder<DebugModuleController>? controllerBuilder,
    Key? key,
  }) : super(
    moduleControllerBuilder: controllerBuilder,
    moduleRouting: const DebugModuleRouting(),
    key: key,
  );
}