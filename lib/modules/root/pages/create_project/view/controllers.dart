import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_create_project/feature_create_project.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

class NameInputController extends InputStateController<CreateProjectEvent, CreateProjectState> {
  const NameInputController();

  @override
  CreateProjectEvent? onChangedEventBuilder(BuildContext context, String value) => CreateProjectNameFieldChanged(value);

  @override
  String? hintSelector(S translations) => translations.root_createProject_nameInputHint;

  @override
  bool disabledSelector(CreateProjectState state) => state.isInProgress || state.isSuccess;
}

class DescriptionInputController extends InputStateController<CreateProjectEvent, CreateProjectState> {
  const DescriptionInputController();

  @override
  CreateProjectEvent? onChangedEventBuilder(BuildContext context, String value) => CreateProjectDescriptionFieldChanged(value);

  @override
  String? hintSelector(S translations) => translations.root_createProject_descriptionInputHint;

  @override
  bool disabledSelector(CreateProjectState state) => state.isInProgress || state.isSuccess;
}

class ContactsInputController extends InputStateController<CreateProjectEvent, CreateProjectState> {
  const ContactsInputController();

  @override
  CreateProjectEvent? onChangedEventBuilder(BuildContext context, String value) => CreateProjectContactsFieldChanged(value);

  @override
  String? hintSelector(S translations) => translations.root_createProject_contactsInputHint;

  @override
  bool disabledSelector(CreateProjectState state) => state.isInProgress || state.isSuccess;
}

class SubmitCreateProjectButtonController extends ButtonStateController<CreateProjectEvent, CreateProjectState> {
  const SubmitCreateProjectButtonController();

  @override
  String textSelector(S translations) => translations.root_createProject_createButtonText;

  @override
  CreateProjectEvent? eventBuilder(BuildContext context) => const CreateProjectSubmitted();

  @override
  bool disabledSelector(CreateProjectState state) => !state.fieldsStatus.isValidated;

  @override
  bool loadingSelector(CreateProjectState state) => state.isInProgress || state.isSuccess;
}