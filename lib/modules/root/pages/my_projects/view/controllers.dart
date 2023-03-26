import 'package:edu_app/common/common.dart';
import 'package:edu_app/modules/root/pages/create_project/create_project_page.dart';
import 'package:edu_app/modules/root/root_module.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProjectsListController extends RefreshableModelsListController<ProjectModel> {
  const MyProjectsListController();

  @override
  Widget itemBuilder(BuildContext context, ProjectModel model) => ProjectCard(
    translations: context.watch<S>(),
    project: model,
    editButtonCallback: () => NavigationProvider.of(context).pushNamed(
      RootModuleRouting.createProject,
      arguments: CreateProjectPageArguments(model),
    ).then((value) {
      if ((value as bool?) ?? false) {
        context.read<ModelsListProviderBloc<ProjectModel>>().add(const ModelsListProviderRefreshRequested(refreshState: true));
      }
    }),
  );
}