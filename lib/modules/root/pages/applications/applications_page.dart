import 'package:edu_app/modules/root/pages/applications/view/applications_view.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';

part 'applications_page_arguments.dart';

class ApplicationsPage extends BasePage<ApplicationsPageArguments> {
  const ApplicationsPage({ Key? key }) : super(
    view: const ApplicationsView(),
    key: key,
  );
}