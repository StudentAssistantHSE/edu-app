import 'package:edu_app/common/common.dart';
import 'package:edu_app/modules/root/pages/projects/view/controllers.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';

class RecommendationsView extends StatefulWidget {
  const RecommendationsView({ Key? key }) : super(key: key);

  @override
  _RecommendationsViewState createState() => _RecommendationsViewState();
}

class _RecommendationsViewState extends State<RecommendationsView> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => EduScaffold(
    appBar: EduAppBar(
      title: const SizedBox(
        height: 40,
        child: EduLogo(),
      ),
    ),
    body: RefreshableModelsList<ProjectModel>(
      scrollController: _scrollController,
      controller: const ProjectsListController(),
      padding: const EdgeInsets.all(16),
    ),
  );
}