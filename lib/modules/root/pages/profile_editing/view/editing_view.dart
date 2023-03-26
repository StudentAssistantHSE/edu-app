import 'package:edu_app/modules/root/pages/profile_editing/view/categories.dart';
import 'package:edu_app/modules/root/pages/profile_editing/view/controllers.dart';
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
      const InputWidget<ProfileEditingBloc, ProfileEditingEvent, ProfileEditingState>(
        settings: EmailInputWidgetSettings(),
        controller: EmailInputController(),
      ),
      const SizedBox(height: 16),
      const InputWidget<ProfileEditingBloc, ProfileEditingEvent, ProfileEditingState>(
        settings: FullNameInputWidgetSettings(),
        controller: FullNameInputController(),
      ),
      const SizedBox(height: 16),
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
            hint: context.select<S, String>((value) => value.root_profileEditing_facultyNotSetText),
            onChanged: (value) => value == null ? null : context.read<ProfileEditingBloc>().add(
              ProfileEditingFacultyChanged(value),
            ),
          );
        },
      ),
      const InputWidget<ProfileEditingBloc, ProfileEditingEvent, ProfileEditingState>(
        settings: _BioInputSettings(),
        controller: BioInputController(),
      ),
      const SizedBox(height: 16),
      const Categories(),
      const SizedBox(height: 16),
      const EduGradientButtonWidget<ProfileEditingBloc, ProfileEditingEvent, ProfileEditingState>(
        controller: SubmitProfileEditingButtonController(),
      ),
      const SizedBox(height: 16),
    ],
  );
}
class _BioInputSettings extends InputWidgetSettings {
  @override
  bool get autocorrect => true;

  @override
  TextInputSuffixType get suffixType => TextInputSuffixType.clear;

  const _BioInputSettings() : super(
    textInputAction: TextInputAction.next,
    autofillHints: null,
    autofocus: false,
  );
}