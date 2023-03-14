import 'package:edu_app/common/common.dart';
import 'package:edu_app/modules/login/login_module.dart';
import 'package:edu_app/modules/login/pages/login/view/controllers.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
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
          ModuleControllerProvider.of<LoginModuleController>(context)?.onSuccessLogin(context, state.resultToken.value!);
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
        PageTitleTextWidget(controller: PageTitleTextController()),
        SizedBox(height: 36),
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
        PrimaryButtonWidget<LoginBloc, LoginEvent, LoginState>(
          controller: SubmitLoginButtonController(),
        ),
        SizedBox(height: 12),
        PrimaryButtonWidget<LoginBloc, LoginEvent, LoginState>(
          controller: RegistrationButtonController(),
          style: PrimaryButtonStyle.elevated,
        ),
      ],
    ),
  );
}