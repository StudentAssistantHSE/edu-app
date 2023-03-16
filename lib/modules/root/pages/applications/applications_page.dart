import 'package:edu_app/modules/root/pages/applications/view/applications_view.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_repositories/edu_repositories.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'applications_page_arguments.dart';

class ApplicationsPage extends BasePage<ApplicationsPageArguments> {
  const ApplicationsPage({ Key? key }) : super(
    view: const ApplicationsView(),
    key: key,
  );
}