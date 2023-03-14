part of 'settings_module.dart';

class SettingsModuleRouting extends BaseModuleRouting<SettingsModuleArguments> {
  static const settings = 'settings';
  static const language = 'language';
  static const themeType = 'theme-type';
  static const measurementScale = 'measurement-scale';
  static const homeScreenGenders = 'home-screen-genders';

  static const moduleName = 'settings';

  static final RoutesTable _table = {
    SettingsModuleRouting.settings: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => const Center(child: Text('settings')),
    ),
    SettingsModuleRouting.language: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => const Center(child: Text('language')),
    ),
    SettingsModuleRouting.themeType: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => const Center(child: Text('themeType')),
    ),
    SettingsModuleRouting.measurementScale: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => const Center(child: Text('measurementScale')),
    ),
    SettingsModuleRouting.homeScreenGenders: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => const Center(child: Text('homeScreenGenders')),
    ),
  };

  @override
  RoutesTable get table => _table;

  const SettingsModuleRouting() : super(moduleName);

  @override
  String? initialRouteBuilder(SettingsModuleArguments? moduleArguments) =>
      SettingsModuleRouting.settings;
}