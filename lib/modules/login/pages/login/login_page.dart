import 'package:edu_app/di/locator.dart';
import 'package:edu_app/modules/login/pages/login/view/login_view.dart';
import 'package:edu_repositories/edu_repositories.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_login/feature_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_page_arguments.dart';

class LoginPage extends BasePage<LoginPageArguments> {
  LoginPage({ Key? key }) : super(
    view: const LoginView(),
    blocsBuilder: (pageContext, pageArguments) => [
      BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          loginRepository: LoginRepository(
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