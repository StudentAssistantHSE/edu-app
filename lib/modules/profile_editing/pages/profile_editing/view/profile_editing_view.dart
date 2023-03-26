import 'package:edu_app/common/common.dart';
import 'package:edu_app/modules/profile_editing/pages/profile_editing/view/controllers.dart';
import 'package:edu_app/modules/profile_editing/pages/profile_editing/view/editing_view.dart';
import 'package:edu_app/modules/profile_editing/profile_editing_module.dart';
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
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async {
      final state = context.read<ProfileEditingBloc>().state;
      if (state.isInProgress) {
        return false;
      }

      return true;
    },
    child: BlocSelector<ModelsListProviderBloc<FacultyModel>, ModelsListProviderState<FacultyModel>, ModelsListProviderStatus>(
      selector: (state) => state.status,
      builder: (context, status) {
        var padding = EdgeInsets.only(bottom: ScreenGrid.bottomListInset(MediaQuery.of(context)));
        Widget body = const Center(
          child: LoadingIndicator(scale: 2),
        );
        if (status == ModelsListProviderStatus.refreshingSuccess) {
          body = const EditingView();
          padding = EdgeInsets.zero;
        }

        if (status == ModelsListProviderStatus.refreshingConnectionError) {
          body = const ErrorView(controller: FacultiesConnectionErrorViewController());
        }
        if (status == ModelsListProviderStatus.refreshingUndefinedError) {
          body = const ErrorView(controller: FacultiesUndefinedErrorViewController());
        }

        return MultiBlocListener(
          listeners: [
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
                  ModuleControllerProvider.of<ProfileEditingModuleController>(context)?.onEditingSuccess();
                }
              },
            ),
          ],
          child: BlocBuilder<ProfileEditingBloc, ProfileEditingState>(
            builder: (context, state) => EduScaffold(
              useSafeArea: false,
              appBar: EduAppBar(
                automaticallyImplyLeading: !state.isInProgress && !state.isSuccess,
                leading: state.isInProgress || state.isSuccess
                  ? null
                  : const EduAppBarBackButton(),
              ),
              body: Padding(
                padding: padding,
                child: body,
              ),
            ),
          ),
        );
      },
    ),
  );
}
