import 'package:edu_app/modules/root/pages/apply_project/view/apply_project_view.dart';
import 'package:edu_repositories/edu_repositories.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_apply_project/feature_apply_project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'apply_project_page_arguments.dart';

class ApplyProjectPage extends BasePage<ApplyProjectPageArguments> {
  ApplyProjectPage({ Key? key }) : super(
    view: const ApplyProjectView(),
    key: key,
    blocsBuilder: (pageContext, pageArguments) => [
      BlocProvider<ApplyProjectBloc>(
        create: (context) => ApplyProjectBloc(
          applyProjectRepository: ApplyProjectRepository(
            context.read<NetworkRepository>(),
          ),
          projectId: pageArguments!.projectId,
        ),
      ),
    ],
  );
}