import 'package:edu_app/modules/categories/pages/categories/view/categories_view.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_repositories/edu_repositories.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_page_arguments.dart';

class CategoriesPage extends BasePage<CategoriesPageArguments> {
  CategoriesPage({ Key? key }) : super(
    view: const CategoriesView(),
    key: key,
    blocsBuilder: (pageContext, pageArguments) => [
      BlocProvider<ModelsListProviderBloc<CategoryModel>>(
        create: (context) => ModelsListProviderBloc<CategoryModel>(
          path: ModelsListProviderPath.accountCategories,
          pageSize: -1,
          modelsListProviderRepository: ModelsListProviderRepository<CategoryModel>(
            context.read<NetworkRepository>(),
            CategoryModel.fromJson,
          ),
        ),
      ),
    ],
  );
}