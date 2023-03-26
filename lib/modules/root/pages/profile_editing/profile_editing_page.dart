import 'package:edu_app/modules/root/pages/profile_editing/view/profile_editing_view.dart';
import 'package:edu_app/modules/root/root_module.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_repositories/edu_repositories.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';
import 'package:feature_profile_editing/feature_profile_editing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_editing_page_arguments.dart';

class ProfileEditingPage extends BasePage<ProfileEditingPageArguments> {
  ProfileEditingPage({ Key? key }) : super(
    view: const ProfileEditingView(),
    key: key,
    blocsBuilder: (pageContext, pageArguments) => [
      BlocProvider<ModelsListProviderBloc<CategoryModel>>(
        create: (context) => ModelsListProviderBloc<CategoryModel>(
          path: ModelsListProviderPath.accountCategories,
          pageSize: -1,
          modelsListProviderRepository: ModelsListProviderRepository<CategoryModel>(
            context.read<NetworkRepository>(),
            CategoryModel.fromJson,
          ),
        )..add(const ModelsListProviderRefreshRequested()),
      ),
      BlocProvider<ModelsListProviderBloc<FacultyModel>>(
        create: (context) => ModelsListProviderBloc<FacultyModel>(
          path: ModelsListProviderPath.faculties,
          pageSize: -1,
          modelsListProviderRepository: ModelsListProviderRepository<FacultyModel>(
            context.read<NetworkRepository>(),
            FacultyModel.fromJson,
          ),
        )..add(const ModelsListProviderRefreshRequested()),
      ),
      BlocProvider<ProfileEditingBloc>(
        create: (context) {
          final initialData = pageArguments?.initialData;
          if (initialData == null) {
            throw const IllegalRouteArgumentsException(
              route: RootModuleRouting.profileEditing,
              moduleName: RootModuleRouting.moduleName,
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
  );
}