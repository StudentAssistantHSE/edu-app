import 'package:edu_app/common/common.dart';
import 'package:edu_app/modules/root/pages/process_application/process_application_page.dart';
import 'package:edu_app/modules/root/root_module.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SentApplicationsListController extends RefreshableModelsListController<ApplicationModel> {
  const SentApplicationsListController();

  @override
  Widget itemBuilder(BuildContext context, ApplicationModel model) => ApplicationCard(
    translations: context.watch<S>(),
    application: model,
  );
}

class IncomingApplicationsListController extends RefreshableModelsListController<ApplicationModel> {
  const IncomingApplicationsListController();

  @override
  Widget itemBuilder(BuildContext context, ApplicationModel model) => ApplicationCard(
    translations: context.watch<S>(),
    application: model,
    onProcessApplication: (statusType) => NavigationProvider.of(context).pushNamed(
      RootModuleRouting.processApplication,
      arguments: ProcessApplicationsPageArguments(model.id, statusType),
    ).then((value) {
      if ((value as bool?) ?? false) {
        context.read<ModelsListProviderBloc<ApplicationModel>>().add(const ModelsListProviderRefreshRequested(refreshState: true));
      }
    }),
  );
}