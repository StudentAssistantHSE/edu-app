import 'package:edu_app/di/locator.dart';
import 'package:edu_app/modules/registration/pages/registration/view/registration_view.dart';
import 'package:edu_repositories/edu_repositories.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_registration/feature_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'registration_page_arguments.dart';

class RegistrationPage extends BasePage<RegistrationPageArguments> {
  RegistrationPage({ Key? key }) : super(
    view: const RegistrationView(),
    blocsBuilder: (pageContext, pageArguments) => [
      BlocProvider<RegistrationBloc>(
        create: (context) => RegistrationBloc(
          registrationRepository: RegistrationRepository(
            context.read<NetworkRepository>(),
          ),
        ),
      ),
    ],
    repositoriesBuilder: (pageContext, pageArguments) => [
      RepositoryProvider<NetworkRepository>(
        create: (context) => locator.repositories.networkRepository(null),
      ),
    ],
    key: key,
  );
}