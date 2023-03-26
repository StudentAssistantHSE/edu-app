import 'package:edu_app/common/lists/base_refreshable_models_list.dart';
import 'package:edu_app/common/lists/refreshable_models_list_controller.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';

class RefreshableModelsStaggeredGridList<T extends BaseModel> extends BaseRefreshableModelsList<T> {
  RefreshableModelsStaggeredGridList({
    required RefreshableModelsListController<T> controller,
    Key? loadingIndicatorKey,
    ScrollController? scrollController,
    EdgeInsets padding = const EdgeInsets.fromLTRB(16, 0, 16, 16),
    Key? key,
  }) : super(
    controller: controller,
    listPadding: padding,
    listViewBuilder: (context, models) => GridView.builder(
      controller: scrollController,
      padding: padding,
      itemBuilder: (context, index) => controller.itemBuilder(context, models[index]),
      itemCount: models.length,
      gridDelegate: EduStaggeredGridDelegate(
        patternKey: models.first.id,
      ),
    ),
    scrollController: scrollController,
    loadingIndicatorKey: loadingIndicatorKey,
    key: key,
  );
}