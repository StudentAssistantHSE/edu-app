import 'package:edu_app/modules/registration/pages/finish_registration/view/finish_registration_view.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';

part 'finish_registration_page_arguments.dart';

class FinishRegistrationPage extends BasePage<FinishRegistrationPageArguments> {
  const FinishRegistrationPage({ Key? key }) : super(
    view: const FinishRegistrationView(),
    key: key,
  );
}