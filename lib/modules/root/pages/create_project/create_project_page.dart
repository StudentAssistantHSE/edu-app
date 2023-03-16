import 'package:edu_app/modules/root/pages/create_project/view/create_project_view.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_repositories/edu_repositories.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_create_project/feature_create_project.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_project_page_arguments.dart';

class CreateProjectPage extends BasePage<CreateProjectPageArguments> {
  CreateProjectPage({ Key? key }) : super(
    view: const CreateProjectView(),
    key: key,
    blocsBuilder: (pageContext, pageArguments) => [
      BlocProvider<CreateProjectBloc>(
        create: (context) => CreateProjectBloc(
          createProjectRepository: CreateProjectRepository(
            context.read<NetworkRepository>(),
          ),
        ),
      ),
      BlocProvider<ModelsListProviderBloc<CategoryModel>>(
        create: (context) => ModelsListProviderBloc<CategoryModel>(
          path: ModelsListProviderPath.projectsCategories,
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