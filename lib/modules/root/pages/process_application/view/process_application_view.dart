import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_authentication/feature_authentication.dart';
import 'package:feature_process_application/feature_process_application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProcessApplicationView extends StatelessWidget {
  const ProcessApplicationView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocListener<ProcessApplicationBloc, ProcessApplicationState>(
    listenWhen: (previous, current) => previous.status != current.status,
    listener: (context, state) {
      final translations = context.read<S>();
      if (state.status == ProcessApplicationStatus.inProgress) {
        NavigationProvider.of(context).lockRoute();
      } else {
        NavigationProvider.of(context).unlockRoute();
      }
      switch (state.status) {
        case ProcessApplicationStatus.success:
          Future<void>.delayed(const Duration(seconds: 1)).then(
            (value) => NavigationProvider.of(context).pop(true),
          );
          break;
        case ProcessApplicationStatus.notAuthorized:
          context.read<AuthenticationBloc>().add(const AuthenticationLoggedOut());
          break;
        case ProcessApplicationStatus.undefinedError:
          EduSnackBar.showError(context, message: translations.login_login_undefinedErrorMessage);
          break;
        case ProcessApplicationStatus.connectionError:
          EduSnackBar.showError(context, message: translations.common_lists_loading_connectionErrorMessage);
          break;
        default:
          break;
      }
    },
    child: WillPopScope(
      onWillPop: () async => false,
      child: const EduScaffold(
        body: Center(child: LoadingIndicator(scale: 2)),
      ),
    ),
  );
}