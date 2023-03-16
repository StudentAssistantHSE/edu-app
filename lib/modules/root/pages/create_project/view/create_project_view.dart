import 'package:edu_app/modules/root/pages/create_project/view/categories.dart';
import 'package:edu_app/modules/root/pages/create_project/view/controllers.dart';
import 'package:edu_localizations/edu_localizations.dart';
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
          NavigationProvider.of(context).pop();
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
        padding: EdgeInsets.symmetric(horizontal: ScreenGrid.getPadding(screenWidth: MediaQuery.of(context).size.width, column: 0)),
        children: const [
          InputWidget<CreateProjectBloc, CreateProjectEvent, CreateProjectState>(
            settings: _NameInputSettings(),
            controller: NameInputController(),
          ),
          SizedBox(height: 16),
          InputWidget<CreateProjectBloc, CreateProjectEvent, CreateProjectState>(
            settings: _DescriptionInputSettings(),
            controller: DescriptionInputController(),
          ),
          SizedBox(height: 16),
          InputWidget<CreateProjectBloc, CreateProjectEvent, CreateProjectState>(
            settings: _ContactsInputSettings(),
            controller: ContactsInputController(),
          ),
          SizedBox(height: 16),
          Categories(),
          SizedBox(height: 16),
          PrimaryButtonWidget<CreateProjectBloc, CreateProjectEvent, CreateProjectState>(
            controller: SubmitCreateProjectButtonController(),
          ),
          SizedBox(height: 16),
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
    autofocus: true,
  );
}

class _DescriptionInputSettings extends InputWidgetSettings {
  @override
  bool get autocorrect => true;

  @override
  int? get maxLines => null;

  const _DescriptionInputSettings() : super(
    textInputAction: TextInputAction.next,
    autofillHints: null,
    autofocus: false,
  );
}

class _ContactsInputSettings extends InputWidgetSettings {
  @override
  bool get autocorrect => true;

  const _ContactsInputSettings() : super(
    textInputAction: TextInputAction.done,
    autofillHints: null,
    autofocus: false,
  );
}