import 'package:edu_app/common/common.dart';
import 'package:edu_app/modules/root/pages/apply_project/apply_project_page.dart';
import 'package:edu_app/modules/root/root_module.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectsListController extends RefreshableModelsListController<ProjectModel> {
  const ProjectsListController();

  @override
  Widget itemBuilder(BuildContext context, ProjectModel model) => ProjectCard(
    translations: context.watch<S>(),
    project: model,
    applyButtonCallback: () => NavigationProvider.of(context).pushNamed(
      RootModuleRouting.applyProject,
      arguments: ApplyProjectPageArguments(model.id),
    ),
  );
}
