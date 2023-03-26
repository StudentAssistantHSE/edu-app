import 'package:edu_app/common/common.dart';
import 'package:edu_app/common/lists/base_refreshable_models_list.dart';
import 'package:edu_app/common/lists/refreshable_models_list_controller.dart';
import 'package:edu_app/modules/categories/pages/categories/view/controllers.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({ Key? key }) : super(key: key);

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  String _search = '';

  @override
  Widget build(BuildContext context) => EduScaffold(
    appBar: EduAppBar(
      leading: const EduAppBarBackButton(),
      title: Builder(
        builder: (context) => TextInput(
          textInputAction: const SearchInputWidgetSettings().textInputAction,
          suffixType: const SearchInputWidgetSettings().suffixType,
          autocorrect: const SearchInputWidgetSettings().autocorrect,
          keyboardType: const SearchInputWidgetSettings().keyboardType,
          inputFormatters: const SearchInputWidgetSettings().inputFormatters,
          maxLength: const SearchInputWidgetSettings().maxLength,
          autofocus: const SearchInputWidgetSettings().autofocus,
          obscure: const SearchInputWidgetSettings().obscure,
          withDelay: const SearchInputWidgetSettings().withDelay,
          maxLines: const SearchInputWidgetSettings().maxLines,
          expands: const SearchInputWidgetSettings().expands,
          textAlignVertical: const SearchInputWidgetSettings().textAlignVertical,

          onChanged: (value) => setState(() => _search = value),
          hint: context.select<S, String>((value) => value.categories_categories_categoriesInputHint),
        ),
      ),
    ),
    body: _CategoriesList(
      search: _search,
      controller: const CategoriesListController(),
    ),
  );
}


class _CategoriesList extends BaseRefreshableModelsList<CategoryModel> {
  _CategoriesList({
    required RefreshableModelsListController<CategoryModel> controller,
    String? search,
    Key? key,
  }) : super(
    controller: controller,
    listPadding: const EdgeInsets.symmetric(vertical: 16),
    listViewBuilder: (context, models) {
      final filteredModels = search == null || search.isEmpty
          ? models
          : [
              CategoryModel(id: -1, category: search, isCustom: true),
              ...models.where((e) => e.category.toLowerCase().contains(search.toLowerCase())),
            ];

      if (filteredModels.isEmpty) {
        return Builder(builder: (context) => Center(child: Text(
          context.select<S, String>((value) => value.common_lists_loading_noItemsMessage),
          style: Theme.of(context).textTheme.bodyMedium,
        )));
      }

      return ListView.separated(
        itemCount: filteredModels.length,
        separatorBuilder: (_, __) => const EduDivider(),
        itemBuilder: (context, index) => controller.itemBuilder(context, filteredModels[index]),
      );
    },
    key: key,
  );
}