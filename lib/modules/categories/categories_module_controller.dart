part of 'categories_module.dart';

abstract class CategoriesModuleController extends BaseModuleController {
  const CategoriesModuleController();

  void onCategorySelected(CategoryModel category);
}