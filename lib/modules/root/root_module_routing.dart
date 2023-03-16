part of 'root_module.dart';

class RootModuleRouting extends BaseModuleRouting<RootModuleArguments> {
  static const root = 'root';

  static const projects = 'projects';
  static const myProjects = 'my-projects';
  static const applications = 'applications';
  static const applyProject = 'apply-project';
  static const createProject = 'create-project';

  static const moduleName = 'root';

  static const initialSharedRoutes = [
    projects,
    myProjects,
    applications,
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
      builder: (context) => MyProjectsPage(),
    ),
    RootModuleRouting.applications: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => const ApplicationsPage(),
    ),
    RootModuleRouting.applyProject: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => ApplyProjectPage(),
    ),
    RootModuleRouting.createProject: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => CreateProjectPage(),
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