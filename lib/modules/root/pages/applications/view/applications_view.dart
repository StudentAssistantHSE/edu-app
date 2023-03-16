import 'package:edu_app/common/common.dart';
import 'package:edu_app/modules/root/pages/applications/view/controllers.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_repositories/edu_repositories.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicationsView extends StatefulWidget {
  const ApplicationsView({ Key? key }) : super(key: key);

  @override
  _ApplicationsViewState createState() => _ApplicationsViewState();
}

class _ApplicationsViewState extends State<ApplicationsView> {
  final _firstTabScrollController = ScrollController();
  final _secondTabScrollController = ScrollController();

  @override
  void dispose() {
    _firstTabScrollController.dispose();
    _secondTabScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 2,
    child: EduScaffold(
      appBar: EduAppBar(
        showBorderOnScroll: false,
        title: const SizedBox(
          height: 40,
          child: EduLogo(),
        ),
        bottom: TabBar(
          dividerColor: Colors.transparent,
          tabs: [
            SizedBox(
              width: double.infinity,
              child: Builder(
                builder: (context) => Tab(
                  text: context.select<S, String>((value) => value.root_applications_sentApplicationsTabTitle),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Builder(
                builder: (context) => Tab(
                  text: context.select<S, String>((value) => value.root_applications_incomingApplicationsTabTitle),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              children: [
                BlocProvider<ModelsListProviderBloc<ApplicationModel>>(
                  create: (context) => ModelsListProviderBloc<ApplicationModel>(
                    path: ModelsListProviderPath.sentApplications,
                    modelsListProviderRepository: ModelsListProviderRepository(
                      context.read<NetworkRepository>(),
                      ApplicationModel.fromJson,
                    ),
                  ),
                  child: RefreshableModelsList<ApplicationModel>(
                    scrollController: _firstTabScrollController,
                    controller: const SentApplicationsListController(),
                    padding: const EdgeInsets.all(16),
                  ),
                ),
                BlocProvider<ModelsListProviderBloc<ApplicationModel>>(
                  create: (context) => ModelsListProviderBloc<ApplicationModel>(
                    path: ModelsListProviderPath.incomingApplications,
                    modelsListProviderRepository: ModelsListProviderRepository(
                      context.read<NetworkRepository>(),
                      ApplicationModel.fromJson,
                    ),
                  ),
                  child: RefreshableModelsList<ApplicationModel>(
                    scrollController: _secondTabScrollController,
                    controller: const IncomingApplicationsListController(),
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}