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
            BottomNavigationBarItem(
              icon: const Icon(CustomIcons.search, size: 24),
              label: translations.root_bottomNavigationBar_searchLabel,
            ),
            BottomNavigationBarItem(
              icon: const Icon(CustomIcons.home, size: 24),
              label: translations.root_bottomNavigationBar_myProjectsLabel,
            ),
            BottomNavigationBarItem(
              icon: const Icon(CustomIcons.comment, size: 24),
              label: translations.root_bottomNavigationBar_applicationsLabel,
            ),
          ],
        );
      },
    ),
  );
}