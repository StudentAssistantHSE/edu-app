import 'package:edu_app/common/lists/base_refreshable_models_list.dart';
import 'package:edu_app/common/lists/refreshable_models_list_controller.dart';
import 'package:edu_models/edu_models.dart';
import 'package:flutter/material.dart';

class RefreshableModelsGridList<T extends BaseModel> extends BaseRefreshableModelsList<T> {
  RefreshableModelsGridList({
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
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
    ),
    loadingIndicatorKey: loadingIndicatorKey,
    scrollController: scrollController,
    key: key,
  );
}