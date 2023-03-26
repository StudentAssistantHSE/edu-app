part of 'profile_editing_module.dart';

class ProfileEditingModuleRouting extends BaseModuleRouting<ProfileEditingModuleArguments> {
  static const profileEditing = 'profile-editing';

  static const moduleName = 'profile-editing';

  static final RoutesTable _table = {
    ProfileEditingModuleRouting.profileEditing: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => ProfileEditingPage(),
    ),
  };

  @override
  RoutesTable get table => _table;

  const ProfileEditingModuleRouting() : super(moduleName);

  @override
  String? initialRouteBuilder(ProfileEditingModuleArguments? moduleArguments) => [
    ProfileEditingModuleRouting.profileEditing,
  ].join('/');
}