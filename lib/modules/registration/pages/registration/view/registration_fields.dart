import 'package:edu_app/modules/registration/pages/registration/view/controllers.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_registration/feature_registration.dart';
import 'package:flutter/material.dart';

class RegistrationFields extends StatelessWidget {
  const RegistrationFields({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    children: const [
      InputWidget<RegistrationBloc, RegistrationEvent, RegistrationState>(
        settings: EmailInputWidgetSettings(autofocus: true),
        controller: EmailInputController(),
      ),
      SizedBox(height: 12),
      InputWidget<RegistrationBloc, RegistrationEvent, RegistrationState>(
        settings: FullNameInputWidgetSettings(),
        controller: FullNameInputController(),
      ),
      SizedBox(height: 12),
      InputWidget<RegistrationBloc, RegistrationEvent, RegistrationState>(
        settings: PasswordInputWidgetSettings(
          autofillHints: [ AutofillHints.newPassword ],
        ),
        controller: PasswordInputController(),
      ),
      SizedBox(height: 12),
      InputWidget<RegistrationBloc, RegistrationEvent, RegistrationState>(
        settings: RepeatedPasswordInputWidgetSettings(
          textInputAction: TextInputAction.done,
        ),
        controller: RepeatedPasswordInputController(),
      ),
      SizedBox(height: 24),
      EduGradientButtonWidget<RegistrationBloc, RegistrationEvent, RegistrationState>(
        controller: SubmitRegistrationButtonController(),
      ),
    ],
  );
}