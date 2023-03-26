import 'package:edu_app/common/common.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_model_provider/feature_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectionErrorViewController extends ErrorViewController {
  @override
  ErrorImageType get type => ErrorImageType.connectionError;

  const ConnectionErrorViewController();

  @override
  String titleSelector(S translations) => translations.root_profile_connectionErrorMessage;

  @override
  String? subtitleSelector(S translations) => null;

  @override
  String tryAgainButtonTextSelector(S translations) => translations.root_profile_tryAgainButtonText;

  @override
  void onTryAgainButtonTap(BuildContext context) => context.read<ModelProviderBloc<UserModel>>()
      .add(const ModelProviderLoadingRequested());
}

class UndefinedErrorViewController extends ErrorViewController {
  @override
  ErrorImageType get type => ErrorImageType.undefinedError;

  const UndefinedErrorViewController();

  @override
  String titleSelector(S translations) => translations.root_profile_undefinedErrorMessageTitle;

  @override
  String? subtitleSelector(S translations) => translations.root_profile_undefinedErrorMessageSubtitle;

  @override
  String tryAgainButtonTextSelector(S translations) => translations.root_profile_tryAgainButtonText;

  @override
  void onTryAgainButtonTap(BuildContext context) => context.read<ModelProviderBloc<UserModel>>()
      .add(const ModelProviderLoadingRequested());
}

class EmailTitleTextController extends TextController {
  const EmailTitleTextController();

  @override
  String? textSelector(S translations) => translations.root_profile_emailTitle;
}

class FullNameTitleTextController extends TextController {
  const FullNameTitleTextController();

  @override
  String? textSelector(S translations) => translations.root_profile_fullNameTitle;
}

class FacultyTitleTextController extends TextController {
  const FacultyTitleTextController();

  @override
  String? textSelector(S translations) => translations.root_profile_facultyTitle;
}

class BioTitleTextController extends TextController {
  const BioTitleTextController();

  @override
  String? textSelector(S translations) => translations.root_profile_bioTitle;
}

class CategoriesTitleTextController extends TextController {
  const CategoriesTitleTextController();

  @override
  String? textSelector(S translations) => translations.root_profile_categoriesTitle;
}