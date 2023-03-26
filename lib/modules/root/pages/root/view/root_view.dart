import 'package:edu_app/modules/root/root_module.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootView extends StatelessWidget {
  const RootView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => EduScaffold(
    useSafeArea: false,
    body: SharedRoutesNavigator(
      onGenerateRoute: ModuleRoutingProvider
          .of<RootModuleRouting, RootModuleArguments>(context)?.onGenerateRoute,
    ),
    bottomNavigationBar: BlocSelector<SharedRoutesNavigatorBloc, SharedRoutesNavigatorState, int>(
      selector: (state) => state.index,
      builder: (context, index) {
        final translations = context.watch<S>();
        return EduBottomNavigationBar(
          currentIndex: index,
          onTap: (index) => context.read<SharedRoutesNavigatorBloc>().add(
            SharedRoutesNavigatorIndexChanged(index),
          ),
          items: [
            EduBottomNavigationBarItem(
              icon: const Icon(CustomIcons.starOutline),
              label: translations.root_bottomNavigationBar_recommendationsLabel,
            ),
            EduBottomNavigationBarItem(
              icon: const Icon(CustomIcons.search),
              label: translations.root_bottomNavigationBar_searchLabel,
            ),
            EduBottomNavigationBarItem(
              icon: const Icon(CustomIcons.home),
              label: translations.root_bottomNavigationBar_myProjectsLabel,
            ),
            EduBottomNavigationBarItem(
              icon: const Icon(CustomIcons.comment),
              label: translations.root_bottomNavigationBar_applicationsLabel,
            ),
            EduBottomNavigationBarItem(
              icon: const Icon(CustomIcons.user),
              label: translations.root_bottomNavigationBar_userLabel,
            ),
          ],
        );
      },
    ),
  );
}