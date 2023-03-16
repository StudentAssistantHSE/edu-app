import 'package:edu_app/common/common.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProjectsListController extends RefreshableModelsListController<ProjectModel> {
  const MyProjectsListController();

  @override
  Widget itemBuilder(BuildContext context, ProjectModel model) {
    final translations = context.read<S>();
    return ProjectCard(
      contactsTitle: translations.root_projects_projectCard_contactsTitle,
      nameTitle: translations.root_projects_projectCard_nameTitle,
      descriptionTitle: translations.root_projects_projectCard_descriptionTitle,
      applyButtonText: translations.root_projects_projectCard_applyButtonText,
      project: model,
    );
  }
}