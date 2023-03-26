import 'package:edu_app/di/locator.dart';
import 'package:edu_app/modules/categories/pages/categories_page.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_repositories/edu_repositories.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_authentication/feature_authentication.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_module_arguments.dart';
part 'categories_module_controller.dart';
part 'categories_module_routing.dart';

class CategoriesModule extends BaseModule<CategoriesModuleArguments, CategoriesModuleRouting, CategoriesModuleController> {
  CategoriesModule({
    ControllerBuilder<CategoriesModuleController>? controllerBuilder,
    Key? key,
  }) : super(
    key: key,
    moduleControllerBuilder: controllerBuilder,
    moduleRouting: const CategoriesModuleRouting(),
    blocsBuilder: (moduleContext, moduleArguments) => [
      BlocProvider<ModelsListProviderBloc<CategoryModel>>(
        create: (context) {
          final path = moduleArguments?.categoriesPath;
          if (path == null) {
            throw const IllegalRouteArgumentsException(
              route: CategoriesModuleRouting.categories,
              moduleName: CategoriesModuleRouting.moduleName,
              nullFields: ['categoriesPath'],
            );
          }
          return ModelsListProviderBloc<CategoryModel>(
            path: path,
            pageSize: -1,
            modelsListProviderRepository: ModelsListProviderRepository<CategoryModel>(
              context.read<NetworkRepository>(),
              CategoryModel.fromJson,
            ),
          );
        },
      ),
    ],
    repositoriesBuilder: (moduleContext, moduleArguments) => [
      RepositoryProvider<NetworkRepository>(
        create: (context) => locator.repositories.networkRepository(
          context.read<AuthenticationBloc>().state.token.value,
        ),
      ),
    ],
  );
}