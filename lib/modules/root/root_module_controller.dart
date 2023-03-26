part of 'root_module.dart';

abstract class RootModuleController extends BaseModuleController {
  const RootModuleController();

  Future<Object?> openProfileEditing(UserModel initialData);
  Future<Object?> openCategories();
}