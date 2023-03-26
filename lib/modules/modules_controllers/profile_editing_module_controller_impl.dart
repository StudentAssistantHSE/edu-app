import 'package:edu_app/di/locator.dart';
import 'package:edu_app/modules/categories/categories_module.dart';
import 'package:edu_app/modules/modules_routes.dart';
import 'package:edu_app/modules/profile_editing/profile_editing_module.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';

class ProfileEditingModuleControllerImpl extends ProfileEditingModuleController {
  const ProfileEditingModuleControllerImpl();

  @override
  void onEditingSuccess() => locator.app.navigation.pop(true);

  @override
  Future<Object?> openCategories() => locator.app.navigation.pushNamed(
    ModulesRoutes.categories,
    arguments: const CategoriesModuleArguments(ModelsListProviderPath.accountCategories),
  );
}