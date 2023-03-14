import 'package:edu_app/modules/registration/pages/finish_registration/finish_registration_page.dart';
import 'package:edu_app/modules/registration/registration_module.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartButton extends StatelessWidget {
  const StartButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => ScreenGrid(
    column: 0,
    additionalOffset: 32,
    child: PrimaryButton(
      text: context.watch<S>().registration_finishRegistration_startButtonText,
      expand: true,
      onPressed: () {
        final token = ArgumentsProvider.of<FinishRegistrationPageArguments>(context)?.token;
        if (token == null || token.isEmpty) {
          throw const IllegalRouteArgumentsException(
            route: RegistrationModuleRouting.finishRegistration,
            moduleName: RegistrationModuleRouting.moduleName,
            nullFields: ['token'],
          );
        }
        ModuleControllerProvider.of<RegistrationModuleController>(context)?.onSuccessRegistration(context, token);
      },
    ),
  );
}