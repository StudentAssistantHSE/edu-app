import 'package:edu_app/common/common.dart';
import 'package:edu_models/edu_models.dart';
import 'package:flutter/material.dart';

class ProjectsListController extends RefreshableModelsListController<ProjectModel> {
  const ProjectsListController();

  @override
  Widget itemBuilder(BuildContext context, ProjectModel model) => Center(child: Text(model.id.toString()));
}