import 'package:edu_app/di/locator.dart';
import 'package:edu_app/modules/root/pages/projects/projects_page.dart';
import 'package:edu_app/modules/root/pages/root/root_page.dart';
import 'package:edu_repositories/edu_repositories.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_authentication/feature_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'root_module_arguments.dart';
part 'root_module_controller.dart';
part 'root_module_routing.dart';

class RootModule extends BaseModule<RootModuleArguments, RootModuleRouting, RootModuleController> {
  RootModule({
    ControllerBuilder<RootModuleController>? controllerBuilder,
    Key? key,
  }) : super(
    moduleControllerBuilder: controllerBuilder,
    moduleRouting: const RootModuleRouting(),
    repositoriesBuilder: (pageContext, pageArguments) => [
      RepositoryProvider<NetworkRepository>(
        create: (context) => locator.repositories.networkRepository(
          context.read<AuthenticationBloc>().state.token.value,
        ),
      ),
    ],
    key: key,
  );
}