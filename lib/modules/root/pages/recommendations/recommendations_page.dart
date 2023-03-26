import 'package:edu_app/modules/root/pages/recommendations/view/recommendations_view.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_repositories/edu_repositories.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'recommendations_page_arguments.dart';

class RecommendationsPage extends BasePage<RecommendationsPageArguments> {
  RecommendationsPage({ Key? key }) : super(
    view: const RecommendationsView(),
    key: key,
    blocsBuilder: (pageContext, pageArguments) => [
      BlocProvider<ModelsListProviderBloc<ProjectModel>>(
        create: (context) => ModelsListProviderBloc<ProjectModel>(
          path: ModelsListProviderPath.recommendations,
          modelsListProviderRepository: ModelsListProviderRepository(
            context.read<NetworkRepository>(),
            ProjectModel.fromJson,
          ),
        ),
      ),
    ],
  );
}