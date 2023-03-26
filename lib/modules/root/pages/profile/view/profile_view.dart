import 'package:edu_app/common/common.dart';
import 'package:edu_app/modules/root/pages/profile/view/controllers.dart';
import 'package:edu_app/modules/root/pages/profile_editing/profile_editing_page.dart';
import 'package:edu_app/modules/root/root_module.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_authentication/feature_authentication.dart';
import 'package:feature_model_provider/feature_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({ Key? key }) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => EduScaffold(
    appBar: EduAppBar(
      title: const SizedBox(
        height: 40,
        child: EduLogo(),
      ),
      actions: [
        Builder(
          builder: (context) {
            final model = context.watch<ModelProviderBloc<UserModel>>().state.model.value;
            if (model == null) {
              return const SizedBox.shrink();
            }
            return EduIconButton(
              icon: const Icon(CustomIcons.pencil),
              onPressed: () => NavigationProvider.of(context).pushNamed(
                RootModuleRouting.profileEditing,
                arguments: ProfileEditingPageArguments(model),
              ).then((value) {
                if ((value as bool?) ?? false) {
                  context.read<ModelProviderBloc<UserModel>>().add(const ModelProviderLoadingRequested(refreshState: true));
                }
              }),
            );
          },
        ),
      ],
    ),
    body: BlocConsumer<ModelProviderBloc<UserModel>, ModelProviderState<UserModel>>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case ModelProviderStatus.success:
            _refreshController.refreshCompleted();
            break;
          case ModelProviderStatus.connectionError:
          case ModelProviderStatus.undefinedError:
            _refreshController.refreshFailed();
            if (state.model.value != null) {
              EduSnackBar.showError(context, message: 'error');
            }
            break;
          case ModelProviderStatus.notAuthorized:
            context.read<AuthenticationBloc>().add(const AuthenticationLoggedOut());
            break;
          default:
            break;
        }
      },
      buildWhen: (previous, current) => previous.model.value != current.model.value
          || previous.status != current.status,
      builder: (context, state) {
        final model = state.model.value;
        if (model == null) {
          if (state.status == ModelProviderStatus.connectionError) {
            return const ErrorView(
              controller: ConnectionErrorViewController(),
            );
          } else if (state.status == ModelProviderStatus.undefinedError) {
            return const ErrorView(
              controller: UndefinedErrorViewController(),
            );
          }

          return const Center(
            child: LoadingIndicator(scale: 2),
          );
        }

        final theme = EduTheme.of(context);
        final faculty = model.faculty;
        final bio = model.bio;
        final horizontalPadding = ScreenGrid.getPadding(screenWidth: MediaQuery.of(context).size.width, column: 0);
        return SmartRefresher(
          header: CustomHeader(
            height: 52,
            builder: (_, __) => const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: LoadingIndicator(scale: 1.2),
            ),
          ),
          onRefresh: () => context.read<ModelProviderBloc<UserModel>>().add(const ModelProviderLoadingRequested()),
          controller: _refreshController,
          child: ListView(
            padding: EdgeInsets.only(
              left: horizontalPadding,
              right: horizontalPadding,
              bottom: ScreenGrid.bottomListInset(MediaQuery.of(context)),
            ),
            children: [
              EduCard(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const TextWidget(
                      textStyle: TextThemeReference.title,
                      controller: EmailTitleTextController(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      model.email,
                      style: theme.textTheme.body,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              EduCard(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const TextWidget(
                      textStyle: TextThemeReference.title,
                      controller: FullNameTitleTextController(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      model.fullName,
                      style: theme.textTheme.body,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              EduCard(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const TextWidget(
                      textStyle: TextThemeReference.title,
                      controller: FacultyTitleTextController(),
                    ),
                    const SizedBox(height: 8),
                    Builder(
                      builder: (context) => Text(
                        faculty?.shortName ?? context.select<S, String>((value) => value.root_profile_facultyNotSetText),
                        style: theme.textTheme.body,
                      ),
                    ),
                    if (faculty != null)
                      const SizedBox(height: 8),
                    if (faculty != null)
                      Text(
                        faculty.name,
                        style: theme.textTheme.body,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              EduCard(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const TextWidget(
                      textStyle: TextThemeReference.title,
                      controller: BioTitleTextController(),
                    ),
                    const SizedBox(height: 8),
                    Builder(
                      builder: (context) => Text(
                        bio == null || bio.isEmpty
                            ? context.select<S, String>((value) => value.root_profile_bioNotSetText)
                            : bio,
                        style: theme.textTheme.body,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              EduCard(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const TextWidget(
                      textStyle: TextThemeReference.title,
                      controller: CategoriesTitleTextController(),
                    ),
                    const SizedBox(height: 8),
                    if (model.categories.isEmpty)
                      Builder(
                        builder: (context) => Text(
                          context.select<S, String>((value) => value.root_profile_categoriesNotSetText),
                          style: theme.textTheme.body,
                        ),
                      )
                    else
                      CategoriesList(categories: model.categories),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              EduGradientButton(
                text: context.select<S, String>((value) => value.root_profile_logoutButtonText),
                onPressed: () => context.read<AuthenticationBloc>().add(const AuthenticationLoggedOut()),
              ),
            ],
          ),
        );
      },
    ),
  );
}