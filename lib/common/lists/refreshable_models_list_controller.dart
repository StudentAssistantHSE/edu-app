import 'package:edu_models/edu_models.dart';
import 'package:flutter/cupertino.dart';

abstract class RefreshableModelsListController<T extends BaseModel> {
  bool get overrideCanRefresh => true;
  bool get overrideCanLoadNextPage => true;

  const RefreshableModelsListController();

  Map<String, dynamic>? queryParameters(BuildContext context) => null;

  Widget itemBuilder(BuildContext context, T model);
}