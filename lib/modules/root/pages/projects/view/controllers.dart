import 'package:edu_app/common/common.dart';
import 'package:edu_app/modules/root/pages/apply_project/apply_project_page.dart';
import 'package:edu_app/modules/root/root_module.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<String> {
  SearchCubit() : super('');

  void setSearch(String search) => emit(search);
}

class ProjectsListController extends RefreshableModelsListController<ProjectModel> {
  const ProjectsListController();

  @override
  Map<String, dynamic> queryParameters(BuildContext context) => <String, dynamic> {
    'search': context.read<SearchCubit>().state,
  };

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

class SearchInputController extends InputStateController<
    ModelsListProviderEvent,
    ModelsListProviderState<ProjectModel>> {
  const SearchInputController();

  @override
  ModelsListProviderEvent? onChangedEventBuilder(BuildContext context, String value) {
    context.read<SearchCubit>().setSearch(value);
    return ModelsListProviderRefreshRequested(
      refreshState: true,
      queryParameters: <String, dynamic> {
        'search': value,
      },
    );
  }

  @override
  String? hintSelector(S translations) => translations.root_projects_search_input_hint;
}