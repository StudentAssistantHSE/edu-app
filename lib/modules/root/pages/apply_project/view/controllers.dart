import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_apply_project/feature_apply_project.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

class MessageInputController extends InputStateController<ApplyProjectEvent, ApplyProjectState> {
  const MessageInputController();

  @override
  ApplyProjectEvent? onChangedEventBuilder(BuildContext context, String value) => ApplyProjectMessageFieldChanged(value);

  @override
  String? hintSelector(S translations) => translations.root_applyProject_messageInputHint;

  @override
  bool disabledSelector(ApplyProjectState state) => state.isInProgress || state.isSuccess;
}

class SubmitApplyProjectButtonController extends ButtonStateController<ApplyProjectEvent, ApplyProjectState> {
  const SubmitApplyProjectButtonController();

  @override
  String textSelector(S translations) => translations.root_applyProject_applyButtonText;

  @override
  ApplyProjectEvent? eventBuilder(BuildContext context) => const ApplyProjectSubmitted();

  @override
  bool disabledSelector(ApplyProjectState state) => !state.fieldsStatus.isValidated;

  @override
  bool loadingSelector(ApplyProjectState state) => state.isInProgress || state.isSuccess;
}