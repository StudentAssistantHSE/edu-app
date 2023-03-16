import 'package:edu_app/modules/root/pages/my_projects/view/my_projects_view.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_repositories/edu_repositories.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_projects_page_arguments.dart';

class MyProjectsPage extends BasePage<MyProjectsPageArguments> {
  MyProjectsPage({ Key? key }) : super(
    view: const MyProjectsView(),
    key: key,
    blocsBuilder: (pageContext, pageArguments) => [
      BlocProvider<ModelsListProviderBloc<ProjectModel>>(
        create: (context) => ModelsListProviderBloc<ProjectModel>(
          path: ModelsListProviderPath.myProjects,
          modelsListProviderRepository: ModelsListProviderRepository(
            context.read<NetworkRepository>(),
            ProjectModel.fromJson,
          ),
        ),
      ),
    ],
  );
}