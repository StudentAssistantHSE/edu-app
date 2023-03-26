import 'package:edu_app/di/locator.dart';
import 'package:edu_app/modules/categories/categories_module.dart';
import 'package:edu_app/modules/modules_routes.dart';
import 'package:edu_app/modules/profile_editing/profile_editing_module.dart';
import 'package:edu_app/modules/root/root_module.dart';
import 'package:edu_models/edu_models.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';

class RootModuleControllerImpl extends RootModuleController {
  const RootModuleControllerImpl();

  @override
  Future<Object?> openProfileEditing(UserModel initialData) =>
      locator.app.navigation.pushNamed(
        ModulesRoutes.profileEditing,
        arguments: ProfileEditingModuleArguments(initialData),
      );

  @override
  Future<Object?> openCategories() => locator.app.navigation.pushNamed(
    ModulesRoutes.categories,
    arguments: const CategoriesModuleArguments(ModelsListProviderPath.projectsCategories),
  );
}