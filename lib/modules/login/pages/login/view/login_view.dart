import 'package:edu_app/common/common.dart';
import 'package:edu_app/modules/login/pages/login/view/controllers.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_authentication/feature_authentication.dart';
import 'package:feature_login/feature_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocListener<LoginBloc, LoginState>(
    listenWhen: (previous, current) => previous.status != current.status,
    listener: (context, state) {
      final translations = context.read<S>();
      switch (state.status) {
        case LoginStatus.success:
          context.read<AuthenticationBloc>().add(AuthenticationLoggedIn(state.resultToken.value!));
          break;
        case LoginStatus.incorrectCredentials:
          EduSnackBar.showError(context, message: translations.login_login_incorrectCredentialsMessage);
          break;
        case LoginStatus.connectionError:
          EduSnackBar.showError(context, message: translations.login_login_connectionErrorMessage);
          break;
        case LoginStatus.undefinedError:
          EduSnackBar.showError(context, message: translations.login_login_undefinedErrorMessage);
          break;
        default:
          break;
      }
    },
    child: const WaveAppBarPageView(
      children: [
        Center(
          child: TextWidget(
            textStyle: TextThemeReference.pageTitle,
            controller: PageTitleTextController(),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 24),
        InputWidget<LoginBloc, LoginEvent, LoginState>(
          settings: EmailInputWidgetSettings(),
          controller: EmailInputController(),
        ),
        SizedBox(height: 12),
        InputWidget<LoginBloc, LoginEvent, LoginState>(
          settings: PasswordInputWidgetSettings(
            textInputAction: TextInputAction.done,
          ),
          controller: PasswordInputController(),
        ),
        SizedBox(height: 24),
        EduGradientButtonWidget<LoginBloc, LoginEvent, LoginState>(
          controller: SubmitLoginButtonController(),
        ),
        SizedBox(height: 12),
        EduOutlinedButtonWidget<LoginBloc, LoginEvent, LoginState>(
          controller: RegistrationButtonController(),
        ),
      ],
    ),
  );
}