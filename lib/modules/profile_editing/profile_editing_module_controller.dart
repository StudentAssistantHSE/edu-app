part of 'profile_editing_module.dart';

abstract class ProfileEditingModuleController extends BaseModuleController {
  const ProfileEditingModuleController();

  void onEditingSuccess();

  Future<Object?> openCategories();
}