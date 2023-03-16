import 'package:edu_app/modules/root/pages/apply_project/view/controllers.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_apply_project/feature_apply_project.dart';
import 'package:feature_authentication/feature_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplyProjectView extends StatelessWidget {
  const ApplyProjectView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocListener<ApplyProjectBloc, ApplyProjectState>(
    listenWhen: (previous, current) => previous.status != current.status,
    listener: (context, state) {
      final translations = context.read<S>();
      switch (state.status) {
        case ApplyProjectStatus.success:
          NavigationProvider.of(context).pop();
          break;
        case ApplyProjectStatus.alreadyApplied:
          EduSnackBar.showError(context, message: translations.root_apply_alreadyAppliedErrorMessage);
          NavigationProvider.of(context).pop();
          break;
        case ApplyProjectStatus.connectionError:
          EduSnackBar.showError(context, message: translations.root_apply_connectionErrorMessage);
          break;
        case ApplyProjectStatus.undefinedError:
          EduSnackBar.showError(context, message: translations.root_apply_undefinedErrorMessage);
          break;
        case ApplyProjectStatus.notAuthorized:
          context.read<AuthenticationBloc>().add(const AuthenticationLoggedOut());
          break;
        default:
          break;
      }
    },
    child: EduScaffold(
      appBar: EduAppBar(),
      body: ScreenGrid(
        column: 0,
        child: Column(
          children: const [
            Expanded(
              child: InputWidget<ApplyProjectBloc, ApplyProjectEvent, ApplyProjectState>(
                settings: _MessageInputSettings(),
                controller: MessageInputController(),
              ),
            ),
            SizedBox(height: 16),
            PrimaryButtonWidget<ApplyProjectBloc, ApplyProjectEvent, ApplyProjectState>(
              controller: SubmitApplyButtonController(),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    ),
  );
}

class _MessageInputSettings extends InputWidgetSettings {
  @override
  int? get maxLines => null;

  @override
  bool get autocorrect => true;

  @override
  bool get expands => true;

  @override
  TextAlignVertical get textAlignVertical => TextAlignVertical.top;

  const _MessageInputSettings() : super(
    textInputAction: TextInputAction.done,
    autofillHints: null,
    autofocus: true,
  );
}