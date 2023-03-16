import 'package:edu_app/common/common.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SentApplicationsListController extends RefreshableModelsListController<ApplicationModel> {
  const SentApplicationsListController();

  @override
  Widget itemBuilder(BuildContext context, ApplicationModel model) {
    final translations = context.watch<S>();
    return ApplicationCard(
      messageTitle: translations.root_applications_applicationCard_messageTitle,
      statusTitle: translations.root_applications_applicationCard_statusTitle,
      statusAppliedText: translations.root_applications_applicationCard_statusAppliedText,
      statusRejectedText: translations.root_applications_applicationCard_statusRejectedText,
      statusAcceptedText: translations.root_applications_applicationCard_statusAcceptedText,
      processApplicationRejectText: translations.root_applications_applicationCard_processApplicationRejectText,
      processApplicationAcceptText: translations.root_applications_applicationCard_processApplicationAcceptText,
      application: model,
    );
  }
}

class IncomingApplicationsListController extends RefreshableModelsListController<ApplicationModel> {
  const IncomingApplicationsListController();

  @override
  Widget itemBuilder(BuildContext context, ApplicationModel model) {
    final translations = context.watch<S>();
    return ApplicationCard(
      messageTitle: translations.root_applications_applicationCard_messageTitle,
      statusTitle: translations.root_applications_applicationCard_statusTitle,
      statusAppliedText: translations.root_applications_applicationCard_statusAppliedText,
      statusRejectedText: translations.root_applications_applicationCard_statusRejectedText,
      statusAcceptedText: translations.root_applications_applicationCard_statusAcceptedText,
      processApplicationRejectText: translations.root_applications_applicationCard_processApplicationRejectText,
      processApplicationAcceptText: translations.root_applications_applicationCard_processApplicationAcceptText,
      application: model,
    );
  }
}