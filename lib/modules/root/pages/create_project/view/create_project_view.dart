import 'package:edu_app/modules/root/pages/create_project/view/categories.dart';
import 'package:edu_app/modules/root/pages/create_project/view/controllers.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_authentication/feature_authentication.dart';
import 'package:feature_create_project/feature_create_project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateProjectView extends StatelessWidget {
  const CreateProjectView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocListener<CreateProjectBloc, CreateProjectState>(
    listenWhen: (previous, current) => previous.status != current.status,
    listener: (context, state) {
      final translations = context.read<S>();
      switch (state.status) {
        case CreateProjectStatus.success:
          NavigationProvider.of(context).pop(true);
          break;
        case CreateProjectStatus.connectionError:
          EduSnackBar.showError(context, message: translations.root_createProject_connectionErrorMessage);
          break;
        case CreateProjectStatus.undefinedError:
          EduSnackBar.showError(context, message: translations.root_createProject_undefinedErrorMessage);
          break;
        case CreateProjectStatus.notAuthorized:
          context.read<AuthenticationBloc>().add(const AuthenticationLoggedOut());
          break;
        default:
          break;
      }
    },
    child: EduScaffold(
      appBar: EduAppBar(),
      body: ListView(
        cacheExtent: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: ScreenGrid.getPadding(screenWidth: MediaQuery.of(context).size.width, column: 0)),
        children: [
          EduCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextWidget(
                  textStyle: TextThemeReference.title,
                  controller: NameTitleTextController(),
                ),
                SizedBox(height: 8),
                InputWidget<CreateProjectBloc, CreateProjectEvent, CreateProjectState>(
                  settings: _NameInputSettings(),
                  controller: NameInputController(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          EduCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextWidget(
                  textStyle: TextThemeReference.title,
                  controller: DescriptionTitleTextController(),
                ),
                SizedBox(height: 8),
                InputWidget<CreateProjectBloc, CreateProjectEvent, CreateProjectState>(
                  settings: _DescriptionInputSettings(),
                  controller: DescriptionInputController(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          EduCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextWidget(
                  textStyle: TextThemeReference.title,
                  controller: ContactsTitleTextController(),
                ),
                SizedBox(height: 8),
                InputWidget<CreateProjectBloc, CreateProjectEvent, CreateProjectState>(
                  settings: _ContactsInputSettings(),
                  controller: ContactsInputController(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          EduCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextWidget(
                  textStyle: TextThemeReference.title,
                  controller: StartDateTitleTextController(),
                ),
                SizedBox(height: 8),
                DateTimeInputWidget<CreateProjectBloc, CreateProjectEvent, CreateProjectState>(
                  controller: StartDateInputController(),
                  suffixType: DateTimeInputSuffixType.clear,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          EduCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextWidget(
                  textStyle: TextThemeReference.title,
                  controller: EndDateTitleTextController(),
                ),
                SizedBox(height: 8),
                DateTimeInputWidget<CreateProjectBloc, CreateProjectEvent, CreateProjectState>(
                  controller: EndDateInputController(),
                  suffixType: DateTimeInputSuffixType.clear,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          EduCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextWidget(
                  textStyle: TextThemeReference.title,
                  controller: ApplicationDeadlineTitleTextController(),
                ),
                SizedBox(height: 8),
                DateTimeInputWidget<CreateProjectBloc, CreateProjectEvent, CreateProjectState>(
                  controller: ApplicationDeadlineInputController(),
                  suffixType: DateTimeInputSuffixType.clear,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          EduCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextWidget(
                  textStyle: TextThemeReference.title,
                  controller: EmploymentTypeTitleTextController(),
                ),
                SizedBox(height: 8),
                SelectionInputWidget<CreateProjectBloc, CreateProjectEvent, CreateProjectState, EmploymentType?>(
                  controller: EmploymentTypeInputController(),
                  suffixType: SelectionInputSuffixType.clear,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          EduCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextWidget(
                  textStyle: TextThemeReference.title,
                  controller: TerritoryTitleTextController(),
                ),
                SizedBox(height: 8),
                InputWidget<CreateProjectBloc, CreateProjectEvent, CreateProjectState>(
                  settings: _TerritoryInputSettings(),
                  controller: TerritoryInputController(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          EduCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextWidget(
                  textStyle: TextThemeReference.title,
                  controller: SkillsTitleTextController(),
                ),
                SizedBox(height: 8),
                InputWidget<CreateProjectBloc, CreateProjectEvent, CreateProjectState>(
                  settings: _SkillsInputSettings(),
                  controller: SkillsInputController(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          EduCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextWidget(
                  textStyle: TextThemeReference.title,
                  controller: CreditNumberTitleTextController(),
                ),
                SizedBox(height: 8),
                SelectionInputWidget<CreateProjectBloc, CreateProjectEvent, CreateProjectState, int?>(
                  controller: CreditNumberInputController(),
                  suffixType: SelectionInputSuffixType.clear,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          EduCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextWidget(
                  textStyle: TextThemeReference.title,
                  controller: CampusTitleTextController(),
                ),
                SizedBox(height: 8),
                SelectionInputWidget<CreateProjectBloc, CreateProjectEvent, CreateProjectState, CampusType?>(
                  controller: CampusInputController(),
                  suffixType: SelectionInputSuffixType.clear,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          EduCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextWidget(
                  textStyle: TextThemeReference.title,
                  controller: ParticipantsNumberTitleTextController(),
                ),
                SizedBox(height: 8),
                SelectionInputWidget<CreateProjectBloc, CreateProjectEvent, CreateProjectState, int?>(
                  controller: ParticipantsNumberInputController(),
                  suffixType: SelectionInputSuffixType.clear,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          EduCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextWidget(
                  textStyle: TextThemeReference.title,
                  controller: ProjectTypeTitleTextController(),
                ),
                SizedBox(height: 8),
                SelectionInputWidget<CreateProjectBloc, CreateProjectEvent, CreateProjectState, ProjectType?>(
                  controller: ProjectTypeInputController(),
                  suffixType: SelectionInputSuffixType.clear,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          EduCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextWidget(
                  textStyle: TextThemeReference.title,
                  controller: WeeklyHoursTitleTextController(),
                ),
                SizedBox(height: 8),
                SelectionInputWidget<CreateProjectBloc, CreateProjectEvent, CreateProjectState, int?>(
                  controller: WeeklyHoursInputController(),
                  suffixType: SelectionInputSuffixType.clear,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Categories(),
          const SizedBox(height: 16),
          const EduGradientButtonWidget<CreateProjectBloc, CreateProjectEvent, CreateProjectState>(
            controller: SubmitCreateProjectButtonController(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );
}

class _NameInputSettings extends InputWidgetSettings {
  @override
  bool get autocorrect => true;

  const _NameInputSettings() : super(
    textInputAction: TextInputAction.next,
    autofillHints: null,
    autofocus: false,
  );
}

class _DescriptionInputSettings extends InputWidgetSettings {
  @override
  bool get autocorrect => true;

  @override
  int? get minLines => 5;

  @override
  TextAlignVertical get textAlignVertical => TextAlignVertical.top;

  @override
  int? get maxLines => null;

  const _DescriptionInputSettings() : super(
    textInputAction: TextInputAction.newline,
    autofillHints: null,
    autofocus: false,
  );
}

class _ContactsInputSettings extends InputWidgetSettings {
  @override
  bool get autocorrect => true;

  const _ContactsInputSettings() : super(
    textInputAction: TextInputAction.next,
    autofillHints: null,
    autofocus: false,
  );
}

class _TerritoryInputSettings extends InputWidgetSettings {
  @override
  bool get autocorrect => true;

  const _TerritoryInputSettings() : super(
    textInputAction: TextInputAction.next,
    autofillHints: null,
    autofocus: false,
  );
}

class _SkillsInputSettings extends InputWidgetSettings {
  @override
  bool get autocorrect => true;

  const _SkillsInputSettings() : super(
    textInputAction: TextInputAction.next,
    autofillHints: null,
    autofocus: false,
  );
}