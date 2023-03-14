import 'package:edu_app/common/lists/base_refreshable_models_list.dart';
import 'package:edu_app/common/lists/refreshable_models_list_controller.dart';
import 'package:edu_models/edu_models.dart';
import 'package:flutter/material.dart';

class RefreshableModelsList<T extends BaseModel> extends BaseRefreshableModelsList<T> {
  RefreshableModelsList({
    required RefreshableModelsListController<T> controller,
    Key? loadingIndicatorKey,
    ScrollController? scrollController,
    EdgeInsets padding = const EdgeInsets.fromLTRB(16, 0, 16, 16),
    Key? key,
  }) : super(
    controller: controller,
    listViewBuilder: (context, models) => ListView.separated(
      controller: scrollController,
      padding: padding,
      itemCount: models.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) => controller.itemBuilder(context, models[index]),
    ),
    loadingIndicatorKey: loadingIndicatorKey,
    scrollController: scrollController,
    key: key,
  );
}