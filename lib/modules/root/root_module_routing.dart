part of 'root_module.dart';

class RootModuleRouting extends BaseModuleRouting<RootModuleArguments> {
  static const root = 'root';

  static const projects = 'projects';
  static const myProjects = 'my-projects';

  static const moduleName = 'root';

  static const initialSharedRoutes = [
    projects,
    myProjects,
  ];

  static final RoutesTable _table = {
    RootModuleRouting.root: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => RootPage(),
    ),
    RootModuleRouting.projects: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => ProjectsPage(),
    ),
    RootModuleRouting.myProjects: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => const Center(child: Text('my projects')),
    ),
  };

  @override
  RoutesTable get table => _table;

  const RootModuleRouting() : super(moduleName);

  @override
  String? initialRouteBuilder(RootModuleArguments? moduleArguments) => [
    RootModuleRouting.root,
  ].join('/');
}