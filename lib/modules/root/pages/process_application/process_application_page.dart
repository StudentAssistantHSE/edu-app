import 'package:edu_app/modules/root/pages/process_application/view/process_application_view.dart';
import 'package:edu_app/modules/root/root_module.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_repositories/edu_repositories.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_process_application/feature_process_application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'process_application_page_arguments.dart';

class ProcessApplicationPage extends BasePage<ProcessApplicationsPageArguments> {
  ProcessApplicationPage({ Key? key }) : super(
    view: const ProcessApplicationView(),
    blocsBuilder: (pageContext, pageArguments) => [
      BlocProvider<ProcessApplicationBloc>(
        create: (context) {
          if (pageArguments == null) {
            throw const IllegalRouteArgumentsException(
              route: RootModuleRouting.processApplication,
              moduleName: RootModuleRouting.moduleName,
              nullFields: ['pageArguments'],
            );
          }
          return ProcessApplicationBloc(
            processApplicationRepository: ProcessApplicationRepository(
              context.read<NetworkRepository>(),
            ),
            applicationId: pageArguments.applicationId,
          )..add(pageArguments.statusType.isAccepted
              ? const ProcessApplicationAccept()
              : pageArguments.statusType.isRejected
              ? const ProcessApplicationReject()
              : (throw const IllegalRouteArgumentsException(
                  route: RootModuleRouting.processApplication,
                  moduleName: RootModuleRouting.moduleName,
                  nullFields: ['statusType'],
                )),
          );
        },
      ),
    ],
    key: key,
  );
}