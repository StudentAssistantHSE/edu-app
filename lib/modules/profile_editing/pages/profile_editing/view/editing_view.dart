import 'package:edu_app/modules/profile_editing/pages/profile_editing/view/controllers.dart';
import 'package:edu_app/modules/profile_editing/profile_editing_module.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';
import 'package:feature_profile_editing/feature_profile_editing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditingView extends StatelessWidget {
  const EditingView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
    padding: EdgeInsets.symmetric(horizontal: ScreenGrid.getPadding(screenWidth: MediaQuery.of(context).size.width, column: 0)),
    children: [
      EduCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TextWidget(
              textStyle: TextThemeReference.title,
              controller: EmailTitleTextController(),
            ),
            SizedBox(height: 8),
            InputWidget<ProfileEditingBloc, ProfileEditingEvent, ProfileEditingState>(
              settings: EmailInputWidgetSettings(),
              controller: EmailInputController(),
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
              controller: FullNameTitleTextController(),
            ),
            SizedBox(height: 8),
            InputWidget<ProfileEditingBloc, ProfileEditingEvent, ProfileEditingState>(
              settings: FullNameInputWidgetSettings(),
              controller: FullNameInputController(),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      EduCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              textStyle: TextThemeReference.title,
              controller: FacultyTitleTextController(),
            ),
            const SizedBox(height: 8),
            Builder(
              builder: (context) {
                final models = context.select<ModelsListProviderBloc<FacultyModel>, List<FacultyModel>>(
                      (value) => value.state.models.value ?? [],
                );
                return DropdownInput<FacultyModel>(
                  items: [
                    for (final model in models)
                      DropdownInputItem<FacultyModel>(key: model, title: model.shortName),
                  ],
                  selectedItem: context.select<ProfileEditingBloc, FacultyModel?>((value) => value.state.faculty),
                  hint: context.select<S, String>((value) => value.profileEditing_profileEditing_facultyNotSetText),
                  onChanged: (value) => value == null ? null : context.read<ProfileEditingBloc>().add(
                    ProfileEditingFacultyChanged(value),
                  ),
                );
              },
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
              controller: BioTitleTextController(),
            ),
            SizedBox(height: 8),
            InputWidget<ProfileEditingBloc, ProfileEditingEvent, ProfileEditingState>(
              settings: _BioInputSettings(),
              controller: BioInputController(),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      EduCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: TextWidget(
                    textStyle: TextThemeReference.title,
                    controller: CategoriesTitleTextController(),
                  ),
                ),
                const SizedBox(width: 16),
                EduIconButton(
                  icon: const Icon(CustomIcons.plus),
                  onPressed: () => ModuleControllerProvider.of<ProfileEditingModuleController>(context)
                      ?.openCategories().then(
                    (value) {
                      if (value is CategoryModel) {
                        context.read<ProfileEditingBloc>().add(
                          value.isCustom
                              ? ProfileEditingCustomCategoryAdded(value.category)
                              : ProfileEditingExistingCategoryAdded(value.id, value.category),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            BlocBuilder<ProfileEditingBloc, ProfileEditingState>(
              buildWhen: (previous, current) => previous.categories != current.categories,
              builder: (context, state) {
                if (state.categories.isEmpty) {
                  return const SizedBox.shrink();
                }
                final theme = EduTheme.of(context);
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 16,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: theme.categoriesListTheme.spacing,
                      runSpacing: theme.categoriesListTheme.spacing,
                      children: [
                        for (final category in state.categories)
                          Chip(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            side: BorderSide.none,
                            shape: const StadiumBorder(),
                            backgroundColor: theme.categoriesListTheme.backgroundColor
                                .resolveColorScheme(theme.colorScheme),
                            label: Text(
                              category.text,
                              style: theme.categoriesListTheme.labelStyle.resolveTextTheme(theme.textTheme)
                                  .copyWith(color: theme.categoriesListTheme.foregroundColor.resolveColorScheme(theme.colorScheme)),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            deleteIcon: Icon(Icons.close_rounded, color: theme.colorScheme.themeMain),
                            onDeleted: () => context.read<ProfileEditingBloc>().add(
                              category is ExistingCategory
                                  ? ProfileEditingExistingCategoryRemoved(category.value)
                                  : category is CustomCategory
                                  ? ProfileEditingCustomCategoryRemoved(category.value)
                                  : ProfileEditingCustomCategoryRemoved(category.text),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      const EduGradientButtonWidget<ProfileEditingBloc, ProfileEditingEvent, ProfileEditingState>(
        controller: SubmitProfileEditingButtonController(),
      ),
      SizedBox(height: ScreenGrid.bottomListInset(MediaQuery.of(context))),
    ],
  );
}
class _BioInputSettings extends InputWidgetSettings {
  @override
  bool get autocorrect => true;

  @override
  int? get maxLines => null;

  @override
  int? get minLines => 5;

  @override
  TextAlignVertical get textAlignVertical => TextAlignVertical.top;

  @override
  TextInputSuffixType get suffixType => TextInputSuffixType.clear;

  const _BioInputSettings() : super(
    textInputAction: TextInputAction.newline,
    autofillHints: null,
    autofocus: false,
  );
}