import 'package:edu_app/common/common.dart';
import 'package:edu_app/modules/login/login_module.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_login/feature_login.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

class PageTitleTextController extends TextStateController {
  const PageTitleTextController();

  @override
  String textSelector(S translations) => translations.login_login_pageTitle;
}

class EmailInputController extends InputStateController<LoginEvent, LoginState> {
  const EmailInputController();

  @override
  LoginEvent? onChangedEventBuilder(BuildContext context, String value) => LoginEmailFieldChanged(value);

  @override
  String? hintSelector(S translations) => translations.login_login_emailOrUsernameInputHint;

  @override
  bool disabledSelector(LoginState state) => state.isInProgress || state.isSuccess;
}

class PasswordInputController extends InputStateController<LoginEvent, LoginState> {
  const PasswordInputController();

  @override
  LoginEvent? onChangedEventBuilder(BuildContext context, String value) => LoginPasswordFieldChanged(value);

  @override
  LoginEvent? onSubmittedEventBuilder(BuildContext context, String value) => const LoginSubmitted();

  @override
  String? hintSelector(S translations) => translations.login_login_passwordInputHint;

  @override
  bool disabledSelector(LoginState state) => state.isInProgress || state.isSuccess;

  @override
  bool canSubmitSelector(LoginState state) => state.fieldsStatus.isValidated;
}

class SubmitLoginButtonController extends ButtonStateController<LoginEvent, LoginState> {
  const SubmitLoginButtonController();

  @override
  String textSelector(S translations) => translations.login_login_submitLoginButtonText;

  @override
  LoginEvent? eventBuilder(BuildContext context) => const LoginSubmitted();

  @override
  bool disabledSelector(LoginState state) => !state.fieldsStatus.isValidated;

  @override
  bool loadingSelector(LoginState state) => state.isInProgress || state.isSuccess;
}

class RegistrationButtonController extends ButtonStateController<LoginEvent, LoginState> {
  const RegistrationButtonController();

  @override
  String textSelector(S translations) => translations.login_login_registrationButtonText;

  @override
  void onPressed(BuildContext context) => ModuleControllerProvider.of<LoginModuleController>(context)?.onOpenRegistration();

  @override
  bool disabledSelector(LoginState state) => state.isInProgress || state.isSuccess;
}