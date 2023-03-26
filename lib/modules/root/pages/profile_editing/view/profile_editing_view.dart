import 'package:edu_app/common/common.dart';
import 'package:edu_app/modules/root/pages/profile_editing/view/controllers.dart';
import 'package:edu_app/modules/root/pages/profile_editing/view/editing_view.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_authentication/feature_authentication.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';
import 'package:feature_profile_editing/feature_profile_editing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditingView extends StatelessWidget {
  const ProfileEditingView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriesStatus = context.select<ModelsListProviderBloc<CategoryModel>, ModelsListProviderStatus>(
      (value) => value.state.status,
    );
    final facultiesStatus = context.select<ModelsListProviderBloc<FacultyModel>, ModelsListProviderStatus>(
      (value) => value.state.status,
    );

    Widget body = const Center(
      child: LoadingIndicator(scale: 2),
    );
    if (categoriesStatus == ModelsListProviderStatus.refreshingSuccess
        && facultiesStatus == ModelsListProviderStatus.refreshingSuccess) {
      body = const EditingView();
    }

    if (categoriesStatus == ModelsListProviderStatus.refreshingConnectionError) {
      body = const ErrorView(controller: CategoriesConnectionErrorViewController());
    }
    if (categoriesStatus == ModelsListProviderStatus.refreshingUndefinedError) {
      body = const ErrorView(controller: CategoriesUndefinedErrorViewController());
    }

    if (facultiesStatus == ModelsListProviderStatus.refreshingConnectionError) {
      body = const ErrorView(controller: FacultiesConnectionErrorViewController());
    }
    if (facultiesStatus == ModelsListProviderStatus.refreshingUndefinedError) {
      body = const ErrorView(controller: FacultiesUndefinedErrorViewController());
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<ModelsListProviderBloc<CategoryModel>, ModelsListProviderState<CategoryModel>>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) => state.status == ModelsListProviderStatus.notAuthorized
              ? context.read<AuthenticationBloc>().add(const AuthenticationLoggedOut()) : null,
        ),
        BlocListener<ModelsListProviderBloc<FacultyModel>, ModelsListProviderState<FacultyModel>>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) => state.status == ModelsListProviderStatus.notAuthorized
              ? context.read<AuthenticationBloc>().add(const AuthenticationLoggedOut()) : null,
        ),
        BlocListener<ProfileEditingBloc, ProfileEditingState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.isInProgress) {
              NavigationProvider.of(context).lockRoute();
            } else {
              NavigationProvider.of(context).unlockRoute();
            }

            if (state.isSuccess) {
              NavigationProvider.of(context).pop(true);
            }
          },
        ),
      ],
      child: BlocBuilder<ProfileEditingBloc, ProfileEditingState>(
        builder: (context, state) => EduScaffold(
          appBar: EduAppBar(
            automaticallyImplyLeading: !state.isInProgress && !state.isSuccess,
          ),
          body: body,
        ),
      ),
    );
  }
}
