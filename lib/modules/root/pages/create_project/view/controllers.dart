import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_create_project/feature_create_project.dart';
import 'package:flutter/material.dart';

class NameInputController extends InputStateController<CreateProjectEvent, CreateProjectState> {
  const NameInputController();

  @override
  String? initialValue(CreateProjectState state) => state.name.value;

  @override
  CreateProjectEvent? onChangedEventBuilder(BuildContext context, String value) => CreateProjectNameFieldChanged(value);

  @override
  String? hintSelector(S translations) => translations.root_createProject_nameInputHint;

  @override
  bool disabledSelector(CreateProjectState state) => state.isInProgress || state.isSuccess;

  @override
  bool errorSelector(CreateProjectState state) => !state.name.isPure && state.name.isNotValid;
}

class DescriptionInputController extends InputStateController<CreateProjectEvent, CreateProjectState> {
  const DescriptionInputController();

  @override
  String? initialValue(CreateProjectState state) => state.description.value;

  @override
  CreateProjectEvent? onChangedEventBuilder(BuildContext context, String value) => CreateProjectDescriptionFieldChanged(value);

  @override
  String? hintSelector(S translations) => translations.root_createProject_descriptionInputHint;

  @override
  bool disabledSelector(CreateProjectState state) => state.isInProgress || state.isSuccess;

  @override
  bool errorSelector(CreateProjectState state) => !state.description.isPure && state.description.isNotValid;
}

class ContactsInputController extends InputStateController<CreateProjectEvent, CreateProjectState> {
  const ContactsInputController();

  @override
  String? initialValue(CreateProjectState state) => state.contacts.value;

  @override
  CreateProjectEvent? onChangedEventBuilder(BuildContext context, String value) => CreateProjectContactsFieldChanged(value);

  @override
  String? hintSelector(S translations) => translations.root_createProject_contactsInputHint;

  @override
  bool disabledSelector(CreateProjectState state) => state.isInProgress || state.isSuccess;

  @override
  bool errorSelector(CreateProjectState state) => !state.contacts.isPure && state.contacts.isNotValid;
}

class StartDateInputController extends DateTimeInputStateController<CreateProjectEvent, CreateProjectState> {
  const StartDateInputController();

  @override
  String? hintSelector(S translations) => translations.root_createProject_startDateInputHint;

  @override
  DateTime startDateTimeSelector(CreateProjectState state) => DateTime.now();

  @override
  DateTime endDateTimeSelector(CreateProjectState state) => DateTime.now().add(const Duration(days: 365 * 5));

  @override
  DateTime? selectedDateTimeSelector(CreateProjectState state) => state.startDateTime.value;

  @override
  bool disabledSelector(CreateProjectState state) => state.isInProgress || state.isSuccess;

  @override
  CreateProjectEvent eventBuilder(BuildContext context, DateTime? value) => CreateProjectStartDateTimeChanged(value);
}

class EndDateInputController extends DateTimeInputStateController<CreateProjectEvent, CreateProjectState> {
  const EndDateInputController();

  @override
  String? hintSelector(S translations) => translations.root_createProject_endDateInputHint;

  @override
  DateTime startDateTimeSelector(CreateProjectState state) => DateTime.now();

  @override
  DateTime endDateTimeSelector(CreateProjectState state) => DateTime.now().add(const Duration(days: 365 * 5));

  @override
  DateTime? selectedDateTimeSelector(CreateProjectState state) => state.endDateTime.value;

  @override
  bool disabledSelector(CreateProjectState state) => state.isInProgress || state.isSuccess;

  @override
  CreateProjectEvent eventBuilder(BuildContext context, DateTime? value) => CreateProjectEndDateTimeChanged(value);
}

class ApplicationDeadlineInputController extends DateTimeInputStateController<CreateProjectEvent, CreateProjectState> {
  const ApplicationDeadlineInputController();

  @override
  String? hintSelector(S translations) => translations.root_createProject_applicationDeadlineInputHint;

  @override
  DateTime startDateTimeSelector(CreateProjectState state) => DateTime.now();

  @override
  DateTime endDateTimeSelector(CreateProjectState state) => DateTime.now().add(const Duration(days: 365 * 5));

  @override
  DateTime? selectedDateTimeSelector(CreateProjectState state) => state.applicationDeadline.value;

  @override
  bool disabledSelector(CreateProjectState state) => state.isInProgress || state.isSuccess;

  @override
  CreateProjectEvent eventBuilder(BuildContext context, DateTime? value) => CreateProjectApplicationDeadlineChanged(value);
}

class EmploymentTypeInputController extends SelectionInputStateController<CreateProjectEvent, CreateProjectState, EmploymentType?> {
  const EmploymentTypeInputController();

  @override
  String? hintSelector(S translations) => translations.root_createProject_employmentTypeInputHint;

  @override
  List<SelectionInputItem<EmploymentType?>> itemsSelector(S translations, CreateProjectState state) => [
    SelectionInputItem(key: EmploymentType.remote, title: translations.root_createProject_employmentTypeRemote),
    SelectionInputItem(key: EmploymentType.onSiteWork, title: translations.root_createProject_employmentTypeOnSiteWork),
    SelectionInputItem(key: EmploymentType.expeditions, title: translations.root_createProject_employmentTypeExpeditions),
    SelectionInputItem(key: EmploymentType.internships, title: translations.root_createProject_employmentTypeInternships),
  ];

  @override
  EmploymentType? selectedItemSelector(CreateProjectState state) => state.employmentType.value;

  @override
  bool disabledSelector(CreateProjectState state) => state.isInProgress || state.isSuccess;

  @override
  CreateProjectEvent eventBuilder(BuildContext context, EmploymentType? value) => CreateProjectEmploymentTypeChanged(value);
}

class TerritoryInputController extends InputStateController<CreateProjectEvent, CreateProjectState> {
  const TerritoryInputController();

  @override
  String? initialValue(CreateProjectState state) => state.territory.value;

  @override
  CreateProjectEvent? onChangedEventBuilder(BuildContext context, String value) => CreateProjectTerritoryFieldChanged(value);

  @override
  String? hintSelector(S translations) => translations.root_createProject_territoryInputHint;

  @override
  bool disabledSelector(CreateProjectState state) => state.isInProgress || state.isSuccess;

  @override
  bool errorSelector(CreateProjectState state) => !state.territory.isPure && state.territory.isNotValid;
}

class SkillsInputController extends InputStateController<CreateProjectEvent, CreateProjectState> {
  const SkillsInputController();

  @override
  String? initialValue(CreateProjectState state) => state.skills.value;

  @override
  CreateProjectEvent? onChangedEventBuilder(BuildContext context, String value) => CreateProjectSkillsFieldChanged(value);

  @override
  String? hintSelector(S translations) => translations.root_createProject_skillsInputHint;

  @override
  bool disabledSelector(CreateProjectState state) => state.isInProgress || state.isSuccess;

  @override
  bool errorSelector(CreateProjectState state) => !state.skills.isPure && state.skills.isNotValid;
}

class CreditNumberInputController extends SelectionInputStateController<CreateProjectEvent, CreateProjectState, int?> {
  const CreditNumberInputController();

  @override
  String? hintSelector(S translations) => translations.root_createProject_creditNumberInputHint;

  @override
  List<SelectionInputItem<int?>> itemsSelector(S translations, CreateProjectState state) => [
    for (var i = 0; i <= 100; i++)
      SelectionInputItem<int?>(key: i, title: i.toString()),
  ];

  @override
  int? selectedItemSelector(CreateProjectState state) => state.creditNumber.value;

  @override
  bool disabledSelector(CreateProjectState state) => state.isInProgress || state.isSuccess;

  @override
  CreateProjectEvent eventBuilder(BuildContext context, int? value) => CreateProjectCreditNumberChanged(value);
}

class CampusInputController extends SelectionInputStateController<CreateProjectEvent, CreateProjectState, CampusType?> {
  const CampusInputController();

  @override
  String? hintSelector(S translations) => translations.root_createProject_campusInputHint;

  @override
  List<SelectionInputItem<CampusType?>> itemsSelector(S translations, CreateProjectState state) => [
    SelectionInputItem(key: CampusType.moscow, title: translations.root_createProject_campusTypeMoscow),
    SelectionInputItem(key: CampusType.nizhniyNovgorod, title: translations.root_createProject_campusTypeNizhniyNovgorod),
    SelectionInputItem(key: CampusType.perm, title: translations.root_createProject_campusTypePerm),
    SelectionInputItem(key: CampusType.saintPetersburg, title: translations.root_createProject_campusTypeSaintPetersburg),
  ];

  @override
  CampusType? selectedItemSelector(CreateProjectState state) => state.campus.value;

  @override
  bool disabledSelector(CreateProjectState state) => state.isInProgress || state.isSuccess;

  @override
  CreateProjectEvent eventBuilder(BuildContext context, CampusType? value) => CreateProjectCampusChanged(value);
}

class ParticipantsNumberInputController extends SelectionInputStateController<CreateProjectEvent, CreateProjectState, int?> {
  const ParticipantsNumberInputController();

  @override
  String? hintSelector(S translations) => translations.root_createProject_participantsNumberInputHint;

  @override
  List<SelectionInputItem<int?>> itemsSelector(S translations, CreateProjectState state) => [
    for (var i = 1; i <= 50; i++)
      SelectionInputItem<int?>(key: i, title: i.toString()),
  ];

  @override
  int? selectedItemSelector(CreateProjectState state) => state.participantsNumber.value;

  @override
  bool disabledSelector(CreateProjectState state) => state.isInProgress || state.isSuccess;

  @override
  CreateProjectEvent eventBuilder(BuildContext context, int? value) => CreateProjectParticipantsNumberChanged(value);
}

class ProjectTypeInputController extends SelectionInputStateController<CreateProjectEvent, CreateProjectState, ProjectType?> {
  const ProjectTypeInputController();

  @override
  String? hintSelector(S translations) => translations.root_createProject_projectTypeInputHint;

  @override
  List<SelectionInputItem<ProjectType?>> itemsSelector(S translations, CreateProjectState state) => [
    SelectionInputItem(key: ProjectType.research, title: translations.root_createProject_projectTypeResearch),
    SelectionInputItem(key: ProjectType.application, title: translations.root_createProject_projectTypeApplication),
    SelectionInputItem(key: ProjectType.service, title: translations.root_createProject_projectTypeService),
  ];

  @override
  ProjectType? selectedItemSelector(CreateProjectState state) => state.projectType.value;

  @override
  bool disabledSelector(CreateProjectState state) => state.isInProgress || state.isSuccess;

  @override
  CreateProjectEvent eventBuilder(BuildContext context, ProjectType? value) => CreateProjectProjectTypeChanged(value);
}

class WeeklyHoursInputController extends SelectionInputStateController<CreateProjectEvent, CreateProjectState, int?> {
  const WeeklyHoursInputController();

  @override
  String? hintSelector(S translations) => translations.root_createProject_weeklyHoursInputHint;

  @override
  List<SelectionInputItem<int?>> itemsSelector(S translations, CreateProjectState state) => [
    for (var i = 1; i <= 168; i++)
      SelectionInputItem<int?>(key: i, title: i.toString()),
  ];

  @override
  int? selectedItemSelector(CreateProjectState state) => state.weeklyHours.value;

  @override
  bool disabledSelector(CreateProjectState state) => state.isInProgress || state.isSuccess;

  @override
  CreateProjectEvent eventBuilder(BuildContext context, int? value) => CreateProjectWeeklyHoursChanged(value);
}

class NameTitleTextController extends TextController {
  const NameTitleTextController();

  @override
  String textSelector(S translations) => translations.root_createProject_nameTitle;
}

class DescriptionTitleTextController extends TextController {
  const DescriptionTitleTextController();

  @override
  String textSelector(S translations) => translations.root_createProject_descriptionTitle;
}

class ContactsTitleTextController extends TextController {
  const ContactsTitleTextController();

  @override
  String textSelector(S translations) => translations.root_createProject_contactsTitle;
}

class StartDateTitleTextController extends TextController {
  const StartDateTitleTextController();

  @override
  String textSelector(S translations) => translations.root_createProject_startDateTitle;
}

class EndDateTitleTextController extends TextController {
  const EndDateTitleTextController();

  @override
  String textSelector(S translations) => translations.root_createProject_endDateTitle;
}

class ApplicationDeadlineTitleTextController extends TextController {
  const ApplicationDeadlineTitleTextController();

  @override
  String textSelector(S translations) => translations.root_createProject_applicationDeadlineTitle;
}

class EmploymentTypeTitleTextController extends TextController {
  const EmploymentTypeTitleTextController();

  @override
  String textSelector(S translations) => translations.root_createProject_employmentTypeTitle;
}

class TerritoryTitleTextController extends TextController {
  const TerritoryTitleTextController();

  @override
  String textSelector(S translations) => translations.root_createProject_territoryTitle;
}

class SkillsTitleTextController extends TextController {
  const SkillsTitleTextController();

  @override
  String textSelector(S translations) => translations.root_createProject_skillsTitle;
}

class CreditNumberTitleTextController extends TextController {
  const CreditNumberTitleTextController();

  @override
  String textSelector(S translations) => translations.root_createProject_creditNumberTitle;
}

class CampusTitleTextController extends TextController {
  const CampusTitleTextController();

  @override
  String textSelector(S translations) => translations.root_createProject_campusTitle;
}

class ParticipantsNumberTitleTextController extends TextController {
  const ParticipantsNumberTitleTextController();

  @override
  String textSelector(S translations) => translations.root_createProject_participantsNumberTitle;
}

class ProjectTypeTitleTextController extends TextController {
  const ProjectTypeTitleTextController();

  @override
  String textSelector(S translations) => translations.root_createProject_projectTypeTitle;
}

class WeeklyHoursTitleTextController extends TextController {
  const WeeklyHoursTitleTextController();

  @override
  String textSelector(S translations) => translations.root_createProject_weeklyHoursNumberTitle;
}

class CategoriesTitleTextController extends TextController {
  const CategoriesTitleTextController();

  @override
  String textSelector(S translations) => translations.root_createProject_categoriesTitle;
}

class SubmitCreateProjectButtonController extends ButtonStateController<CreateProjectEvent, CreateProjectState> {
  const SubmitCreateProjectButtonController();

  @override
  String textSelector(S translations) => translations.root_createProject_createButtonText;

  @override
  CreateProjectEvent? eventBuilder(BuildContext context) => const CreateProjectSubmitted();

  @override
  bool loadingSelector(CreateProjectState state) => state.isInProgress || state.isSuccess;
}