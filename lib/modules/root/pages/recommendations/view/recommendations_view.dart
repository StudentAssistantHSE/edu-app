import 'package:edu_app/common/common.dart';
import 'package:edu_app/modules/root/pages/recommendations/view/controllers.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';

class RecommendationsView extends StatelessWidget {
  const RecommendationsView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => EduScaffold(
    appBar: EduAppBar(
      title: const SizedBox(
        height: 40,
        child: EduLogo(),
      ),
    ),
    body: RefreshableModelsList<ProjectModel>(
      controller: const ProjectsListController(),
      padding: const EdgeInsets.all(16),
    ),
  );
}