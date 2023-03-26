import 'package:edu_app/common/common.dart';
import 'package:edu_app/modules/root/pages/my_projects/view/controllers.dart';
import 'package:edu_app/modules/root/root_module.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';

class MyProjectsView extends StatelessWidget {
  const MyProjectsView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => EduScaffold(
    appBar: EduAppBar(
      title: const SizedBox(
        height: 40,
        child: EduLogo(),
      ),
    ),
    body: RefreshableModelsList<ProjectModel>(
      controller: const MyProjectsListController(),
    ),
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.add_rounded),
      onPressed: () => NavigationProvider.of(context).pushNamed(
        RootModuleRouting.createProject,
      ),
    ),
  );
}