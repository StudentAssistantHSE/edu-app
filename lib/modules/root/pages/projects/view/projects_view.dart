import 'package:edu_app/common/common.dart';
import 'package:edu_app/modules/root/pages/projects/view/controllers.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectsView extends StatelessWidget {
  const ProjectsView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<SearchCubit>(
    create: (context) => SearchCubit(),
    child: EduScaffold(
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
        controller: const ProjectsListController(),
        padding: const EdgeInsets.all(16),
      ),
    ),
  );
}