import 'package:edu_app/di/locator.dart';
import 'package:edu_app/modules/categories/categories_module.dart';
import 'package:edu_models/edu_models.dart';

class CategoriesModuleControllerImpl extends CategoriesModuleController {
  const CategoriesModuleControllerImpl();

  @override
  void onCategorySelected(CategoryModel category) => locator.app.navigation.pop(category);
}