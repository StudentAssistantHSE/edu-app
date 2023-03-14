import 'package:edu_app/common/common.dart';
import 'package:edu_core/edu_core.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_registration/feature_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class PageTitleTextController extends TextStateController {
  const PageTitleTextController();

  @override
  String textSelector(S translations) => translations.registration_registration_pageTitle;
}

class EmailInputController extends InputStateController<RegistrationEvent, RegistrationState> {
  const EmailInputController();

  @override
  String? initialValue(RegistrationState state) => state.email.value;

  @override
  RegistrationEvent? onChangedEventBuilder(BuildContext context, String value) => RegistrationEmailFieldChanged(value);

  @override
  String? hintSelector(S translations) => translations.registration_registration_emailInputHint;

  @override
  bool disabledSelector(RegistrationState state) => state.isInProgress;
}

class FullNameInputController extends InputStateController<RegistrationEvent, RegistrationState> {
  const FullNameInputController();

  @override
  String? initialValue(RegistrationState state) => state.fullName.value;

  @override
  RegistrationEvent? onChangedEventBuilder(BuildContext context, String value) => RegistrationFullNameFieldChanged(value);

  @override
  String? hintSelector(S translations) => translations.registration_registration_usernameInputHint;

  @override
  bool disabledSelector(RegistrationState state) => state.isInProgress;
}

class PasswordInputController extends InputStateController<RegistrationEvent, RegistrationState> {
  @override
  bool get isValidationPrefixTappable => true;

  const PasswordInputController();

  @override
  RegistrationEvent? onChangedEventBuilder(BuildContext context, String value) => RegistrationPasswordFieldChanged(value);

  @override
  String? hintSelector(S translations) => translations.registration_registration_passwordInputHint;

  @override
  bool disabledSelector(RegistrationState state) => state.isInProgress;

  @override
  bool? isValidSelector(RegistrationState state) => state.password.valid;

  @override
  void onValidationPrefixPressed(BuildContext context, RegistrationState state) {
    final translations = context.read<S>();
    final passwordValue = state.password.value;

    EduDialog.showCheckListDialog(
      context,
      title: translations.registration_registration_passwordRequiredSymbolsDialogTitle,
      items: [
        CheckListItem(
          translations.registration_registration_passwordRequiredFromToSymbols(8, 128),
          isCompleted: passwordValue.length >= 8 && passwordValue.length <= 128,
        ),
        CheckListItem(
          translations.registration_registration_passwordRequiredSymbolsDialogLowercaseLatinLettersItem,
          isCompleted: RegExpUtils.anyLowercaseLatinLetter.hasMatch(passwordValue),
        ),
        CheckListItem(
          translations.registration_registration_passwordRequiredSymbolsDialogUppercaseLatinLettersItem,
          isCompleted: RegExpUtils.anyUppercaseLatinLetter.hasMatch(passwordValue),
        ),
        CheckListItem(
          translations.registration_registration_passwordRequiredSymbolsDialogDigitsItem,
          isCompleted: RegExpUtils.anyDigit.hasMatch(passwordValue),
        ),
      ],
      actionTranslation: translations.registration_registration_passwordRequiredSymbolsDialogActionText,
    );
  }
}

class RepeatedPasswordInputController extends InputStateController<RegistrationEvent, RegistrationState> {
  const RepeatedPasswordInputController();

  @override
  RegistrationEvent? onChangedEventBuilder(BuildContext context, String value) => RegistrationRepeatedPasswordFieldChanged(value);

  @override
  RegistrationEvent? onSubmittedEventBuilder(BuildContext context, String value) => const RegistrationSubmitted();

  @override
  String? hintSelector(S translations) => translations.registration_registration_repeatPasswordInputHint;

  @override
  bool disabledSelector(RegistrationState state) => state.isInProgress;

  @override
  bool canSubmitSelector(RegistrationState state) => state.fieldsStatus.isValidated;
}

class SubmitRegistrationButtonController extends ButtonStateController<RegistrationEvent, RegistrationState> {
  const SubmitRegistrationButtonController();

  @override
  String textSelector(S translations) => translations.registration_registration_submitRegistrationButtonText;

  @override
  RegistrationEvent? eventBuilder(BuildContext context) => const RegistrationSubmitted();

  @override
  bool disabledSelector(RegistrationState state) => !state.fieldsStatus.isValidated;

  @override
  void onPressed(BuildContext context) => FocusManager.instance.primaryFocus?.unfocus();

  @override
  bool loadingSelector(RegistrationState state) => state.isInProgress;
}