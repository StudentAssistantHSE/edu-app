part of 'categories_module.dart';

class CategoriesModuleRouting extends BaseModuleRouting<CategoriesModuleArguments> {
  static const categories = 'categories';

  static const moduleName = 'categories';

  static final RoutesTable _table = {
    CategoriesModuleRouting.categories: (settings) => MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => CategoriesPage(),
    ),
  };

  @override
  RoutesTable get table => _table;

  const CategoriesModuleRouting() : super(moduleName);

  @override
  String? initialRouteBuilder(CategoriesModuleArguments? moduleArguments) => [
    CategoriesModuleRouting.categories,
  ].join('/');
}