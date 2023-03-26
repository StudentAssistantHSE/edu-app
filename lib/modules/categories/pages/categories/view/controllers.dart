import 'package:edu_app/common/common.dart';
import 'package:edu_app/modules/categories/categories_module.dart';
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

class SearchInputController extends InputStateController<void, void> {
  const SearchInputController();

  @override
  void onChangedEventBuilder(BuildContext context, String value) {
    context.read<SearchCubit>();
  }

  @override
  String? hintSelector(S translations) => translations.root_projects_search_input_hint;
}

class CategoriesListController extends RefreshableModelsListController<CategoryModel> {
  const CategoriesListController();

  @override
  Widget itemBuilder(BuildContext context, CategoryModel model) => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () => ModuleControllerProvider.of<CategoriesModuleController>(context)?.onCategorySelected(model),
    child: ListItem(text: model.category),
  );
}

class CategoriesConnectionErrorViewController extends ErrorViewController {
  @override
  ErrorImageType get type => ErrorImageType.connectionError;

  const CategoriesConnectionErrorViewController();

  @override
  String titleSelector(S translations) => translations.profileEditing_profileEditing_connectionErrorMessage;

  @override
  String? subtitleSelector(S translations) => null;

  @override
  String tryAgainButtonTextSelector(S translations) => translations.profileEditing_profileEditing_tryAgainButtonText;

  @override
  void onTryAgainButtonTap(BuildContext context) => context.read<ModelsListProviderBloc<CategoryModel>>()
      .add(const ModelsListProviderRefreshRequested());
}

class CategoriesUndefinedErrorViewController extends ErrorViewController {
  @override
  ErrorImageType get type => ErrorImageType.undefinedError;

  const CategoriesUndefinedErrorViewController();

  @override
  String titleSelector(S translations) => translations.profileEditing_profileEditing_undefinedErrorMessageTitle;

  @override
  String? subtitleSelector(S translations) => translations.profileEditing_profileEditing_undefinedErrorMessageSubtitle;

  @override
  String tryAgainButtonTextSelector(S translations) => translations.profileEditing_profileEditing_tryAgainButtonText;

  @override
  void onTryAgainButtonTap(BuildContext context) => context.read<ModelsListProviderBloc<CategoryModel>>()
      .add(const ModelsListProviderRefreshRequested());
}