import 'package:edu_app/common/common.dart';
import 'package:edu_app/modules/registration/pages/finish_registration/finish_registration_page.dart';
import 'package:edu_app/modules/registration/pages/registration/view/controllers.dart';
import 'package:edu_app/modules/registration/pages/registration/view/registration_fields.dart';
import 'package:edu_app/modules/registration/registration_module.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_registration/feature_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async {
      final state = context.read<RegistrationBloc>().state;
      if (state.isInProgress) {
        return false;
      }

      return true;
    },
    child: BlocListener<RegistrationBloc, RegistrationState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final translations = context.read<S>();
        switch (state.status) {
          case RegistrationStatus.noRepeatedPasswordMatch:
            EduSnackBar.showError(context, message: translations.registration_registration_noRepeatedPasswordMatchMessage);
            break;
          case RegistrationStatus.registrationError:
            EduSnackBar.showError(context, message: translations.registration_registration_undefinedErrorMessage);
            break;
          case RegistrationStatus.undefinedError:
            EduSnackBar.showError(context, message: translations.registration_registration_undefinedErrorMessage);
            break;
          case RegistrationStatus.connectionError:
            EduSnackBar.showError(context, message: translations.registration_registration_connectionErrorMessage);
            break;
          case RegistrationStatus.success:
            NavigationProvider.of(context).pushReplacementNamed(
              RegistrationModuleRouting.finishRegistration,
              arguments: FinishRegistrationPageArguments(state.resultToken.value!),
            );
            break;
          default:
            break;
        }
      },
      child: BlocListener<RegistrationBloc, RegistrationState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) =>
          ModuleControllerProvider.of<RegistrationModuleController>(context)
              ?.useWillPopScope.value = state.isInProgress,
        child: BlocSelector<RegistrationBloc, RegistrationState, bool>(
          selector: (state) => state.isInProgress,
          builder: (context, isInProgress) => WaveAppBarPageView(
            automaticallyApplyLeading: !isInProgress,
            leading: isInProgress
                ? null
                : const EduAppBarBackButton(rootNavigator: true),
            children: const [
              SizedBox(height: 28),
              PageTitleTextWidget(
                controller: PageTitleTextController(),
              ),
              SizedBox(height: 24),
              RegistrationFields(),
            ],
          ),
        ),
      ),
    ),
  );
}