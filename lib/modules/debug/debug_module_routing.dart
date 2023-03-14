part of 'debug_module.dart';

class DebugModuleRouting extends BaseModuleRouting<DebugModuleArguments> {
  static const debug = 'debug';

  static const moduleName = 'debug';

  static final RoutesTable _table = {
    DebugModuleRouting.debug: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => const DebugPage(),
    ),
  };

  @override
  RoutesTable get table => _table;

  const DebugModuleRouting() : super(moduleName);

  @override
  String? initialRouteBuilder(DebugModuleArguments? moduleArguments) => [
    DebugModuleRouting.debug,
  ].join('/');
}