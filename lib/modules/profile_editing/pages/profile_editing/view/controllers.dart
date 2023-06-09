import 'package:edu_app/common/common.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';
import 'package:feature_profile_editing/feature_profile_editing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FacultiesConnectionErrorViewController extends ErrorViewController {
  @override
  ErrorImageType get type => ErrorImageType.connectionError;

  const FacultiesConnectionErrorViewController();

  @override
  String titleSelector(S translations) => translations.profileEditing_profileEditing_connectionErrorMessage;

  @override
  String? subtitleSelector(S translations) => null;

  @override
  String tryAgainButtonTextSelector(S translations) => translations.profileEditing_profileEditing_tryAgainButtonText;

  @override
  void onTryAgainButtonTap(BuildContext context) => context.read<ModelsListProviderBloc<FacultyModel>>()
      .add(const ModelsListProviderRefreshRequested());
}

class FacultiesUndefinedErrorViewController extends ErrorViewController {
  @override
  ErrorImageType get type => ErrorImageType.undefinedError;

  const FacultiesUndefinedErrorViewController();

  @override
  String titleSelector(S translations) => translations.profileEditing_profileEditing_undefinedErrorMessageTitle;

  @override
  String? subtitleSelector(S translations) => translations.profileEditing_profileEditing_undefinedErrorMessageSubtitle;

  @override
  String tryAgainButtonTextSelector(S translations) => translations.profileEditing_profileEditing_tryAgainButtonText;

  @override
  void onTryAgainButtonTap(BuildContext context) => context.read<ModelsListProviderBloc<FacultyModel>>()
      .add(const ModelsListProviderRefreshRequested());
}

class EmailTitleTextController extends TextController {
  const EmailTitleTextController();

  @override
  String textSelector(S translations) => translations.profileEditing_profileEditing_emailTitle;
}

class FullNameTitleTextController extends TextController {
  const FullNameTitleTextController();

  @override
  String textSelector(S translations) => translations.profileEditing_profileEditing_fullNameTitle;
}

class FacultyTitleTextController extends TextController {
  const FacultyTitleTextController();

  @override
  String textSelector(S translations) => translations.profileEditing_profileEditing_facultyTitle;
}

class BioTitleTextController extends TextController {
  const BioTitleTextController();

  @override
  String textSelector(S translations) => translations.profileEditing_profileEditing_bioTitle;
}

class CategoriesTitleTextController extends TextController {
  const CategoriesTitleTextController();

  @override
  String textSelector(S translations) => translations.profileEditing_profileEditing_categoriesTitle;
}

class EmailInputController extends InputStateController<ProfileEditingEvent, ProfileEditingState> {
  const EmailInputController();

  @override
  String? initialValue(ProfileEditingState state) => state.email.value;

  @override
  ProfileEditingEvent? onChangedEventBuilder(BuildContext context, String value) => ProfileEditingEmailFieldChanged(value);

  @override
  String? hintSelector(S translations) => translations.profileEditing_profileEditing_emailInputHint;

  @override
  bool errorSelector(ProfileEditingState state) => !state.email.isPure && state.email.isNotValid;

  @override
  bool disabledSelector(ProfileEditingState state) => state.isInProgress;
}

class FullNameInputController extends InputStateController<ProfileEditingEvent, ProfileEditingState> {
  const FullNameInputController();

  @override
  String? initialValue(ProfileEditingState state) => state.fullName.value;

  @override
  ProfileEditingEvent? onChangedEventBuilder(BuildContext context, String value) => ProfileEditingFullNameFieldChanged(value);

  @override
  String? hintSelector(S translations) => translations.profileEditing_profileEditing_fullNameInputHint;

  @override
  bool errorSelector(ProfileEditingState state) => !state.fullName.isPure && state.fullName.isNotValid;

  @override
  bool disabledSelector(ProfileEditingState state) => state.isInProgress;
}

class BioInputController extends InputStateController<ProfileEditingEvent, ProfileEditingState> {
  const BioInputController();

  @override
  String? initialValue(ProfileEditingState state) => state.bio.value;

  @override
  ProfileEditingEvent? onChangedEventBuilder(BuildContext context, String value) => ProfileEditingBioFieldChanged(value);

  @override
  String? hintSelector(S translations) => translations.profileEditing_profileEditing_bioNotSetText;

  @override
  bool errorSelector(ProfileEditingState state) => !state.bio.isPure && state.bio.isNotValid;

  @override
  bool disabledSelector(ProfileEditingState state) => state.isInProgress;
}

class SubmitProfileEditingButtonController extends ButtonStateController<ProfileEditingEvent, ProfileEditingState> {
  const SubmitProfileEditingButtonController();

  @override
  String textSelector(S translations) => translations.profileEditing_profileEditing_submitButtonText;

  @override
  ProfileEditingEvent? eventBuilder(BuildContext context) => const ProfileEditingSubmitted();

  @override
  bool loadingSelector(ProfileEditingState state) => state.isInProgress || state.isSuccess;
}