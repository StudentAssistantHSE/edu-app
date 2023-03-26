import 'package:edu_app/modules/root/pages/profile/view/profile_view.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_repositories/edu_repositories.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_model_provider/feature_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_page_arguments.dart';

class ProfilePage extends BasePage<ProfilePageArguments> {
  ProfilePage({ Key? key }) : super(
    view: const ProfileView(),
    key: key,
    blocsBuilder: (pageContext, pageArguments) => [
      BlocProvider<ModelProviderBloc<UserModel>>(
        create: (context) => ModelProviderBloc<UserModel>(
          path: ModelProviderPath.account,
          modelProviderRepository: ModelProviderRepository(
            context.read<NetworkRepository>(),
            UserModel.fromJson,
          ),
        )..add(const ModelProviderLoadingRequested()),
      ),
    ],
  );
}