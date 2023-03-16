import 'package:edu_app/common/common.dart';
import 'package:edu_app/modules/root/pages/projects/view/controllers.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';
import 'package:flutter/material.dart';

class ProjectsView extends StatefulWidget {
  const ProjectsView({ Key? key }) : super(key: key);

  @override
  _ProjectsViewState createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => EduScaffold(
    appBar: EduAppBar(
      title: const InputWidget<
        ModelsListProviderBloc<ProjectModel>,
        ModelsListProviderEvent,
        ModelsListProviderState<ProjectModel>>(
        settings: SearchInputWidgetSettings(),
        controller: SearchInputController(),
      ),
    ),
    body: RefreshableModelsList<ProjectModel>(
      scrollController: _scrollController,
      controller: const ProjectsListController(),
      padding: const EdgeInsets.all(16),
    ),
  );
}