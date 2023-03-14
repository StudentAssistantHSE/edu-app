import 'package:edu_app/modules/root/pages/root/view/root_view.dart';
import 'package:edu_app/modules/root/root_module.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'root_page_arguments.dart';

class RootPage extends BasePage<RootPageArguments> {
  RootPage({ Key? key }) : super(
    view: const RootView(),
    blocsBuilder: (pageContext, pageArguments) => [
      BlocProvider<SharedRoutesNavigatorBloc>(
        create: (_) => SharedRoutesNavigatorBloc(
          initialIndex: 2,
          initialRoutes: RootModuleRouting.initialSharedRoutes,
        ),
      ),
    ],
    key: key,
  );
}