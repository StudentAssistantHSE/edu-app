import 'package:edu_app/modules/login/login_module.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_login/feature_login.dart';
import 'package:flutter/material.dart';

class PageTitleTextController extends TextController {
  const PageTitleTextController();

  @override
  String textSelector(S translations) => translations.login_login_pageTitle;
}

class EmailInputController extends InputStateController<LoginEvent, LoginState> {
  const EmailInputController();

  @override
  String? initialValue(LoginState state) => state.email.value;

  @override
  LoginEvent? onChangedEventBuilder(BuildContext context, String value) => LoginEmailFieldChanged(value);

  @override
  String? hintSelector(S translations) => translations.login_login_emailOrUsernameInputHint;

  @override
  bool errorSelector(LoginState state) => !state.email.isPure && state.email.isNotValid;

  @override
  bool disabledSelector(LoginState state) => state.isInProgress || state.isSuccess;
}

class PasswordInputController extends InputStateController<LoginEvent, LoginState> {
  const PasswordInputController();

  @override
  String? initialValue(LoginState state) => state.password.value;

  @override
  LoginEvent? onChangedEventBuilder(BuildContext context, String value) => LoginPasswordFieldChanged(value);

  @override
  LoginEvent? onSubmittedEventBuilder(BuildContext context, String value) => const LoginSubmitted();

  @override
  String? hintSelector(S translations) => translations.login_login_passwordInputHint;

  @override
  bool errorSelector(LoginState state) => !state.password.isPure && state.password.isNotValid;

  @override
  bool disabledSelector(LoginState state) => state.isInProgress || state.isSuccess;
}

class SubmitLoginButtonController extends ButtonStateController<LoginEvent, LoginState> {
  const SubmitLoginButtonController();

  @override
  String textSelector(S translations) => translations.login_login_submitLoginButtonText;

  @override
  LoginEvent? eventBuilder(BuildContext context) => const LoginSubmitted();

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