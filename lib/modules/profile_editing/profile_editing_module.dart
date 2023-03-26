import 'package:edu_app/di/locator.dart';
import 'package:edu_app/modules/profile_editing/pages/profile_editing/profile_editing_page.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_repositories/edu_repositories.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_authentication/feature_authentication.dart';
import 'package:feature_profile_editing/feature_profile_editing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_editing_module_arguments.dart';
part 'profile_editing_module_controller.dart';
part 'profile_editing_module_routing.dart';

class ProfileEditingModule extends BaseModule<ProfileEditingModuleArguments, ProfileEditingModuleRouting, ProfileEditingModuleController> {
  ProfileEditingModule({
    ControllerBuilder<ProfileEditingModuleController>? controllerBuilder,
    Key? key,
  }) : super(
    moduleControllerBuilder: controllerBuilder,
    moduleRouting: const ProfileEditingModuleRouting(),
    blocsBuilder: (moduleContext, moduleArguments) => [
      BlocProvider<ProfileEditingBloc>(
        create: (context) {
          final initialData = moduleArguments?.initialData;
          if (initialData == null) {
            throw const IllegalRouteArgumentsException(
              route: ProfileEditingModuleRouting.profileEditing,
              moduleName: ProfileEditingModuleRouting.moduleName,
              nullFields: ['initialData'],
            );
          }
          return ProfileEditingBloc(
            initialData: initialData,
            profileEditingRepository: ProfileEditingRepository(
              context.read<NetworkRepository>(),
            ),
          );
        },
      ),
    ],
    repositoriesBuilder: (moduleContext, moduleArguments) => [
      RepositoryProvider<NetworkRepository>(
        create: (context) => locator.repositories.networkRepository(
          context.read<AuthenticationBloc>().state.token.value,
        ),
      ),
    ],
    key: key,
  );
}