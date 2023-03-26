import 'package:edu_app/app/debug_button.dart';
import 'package:edu_app/di/locator.dart';
import 'package:edu_app/modules/modules_routes.dart';
import 'package:edu_core/edu_core.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_authentication/feature_authentication.dart';
import 'package:feature_settings/feature_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EduApp extends StatelessWidget {
  const EduApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            authenticationRepository: locator.repositories.authentication,
          ),
        ),
        BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(
            settingsRepository: locator.repositories.settings,
          ),
        ),
      ],
      child: const _App(),
    );
  }
}

class _App extends StatelessWidget {
  const _App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select<SettingsBloc, ThemeType>((value) => value.state.settings.themeType).themeData;
    return BlocListener<AuthenticationBloc, AuthenticationState> (
      listener: (context, state) => state.isAuthenticated
          ? locator.app.navigation.pushNamedAndRemoveUntil(
              ModulesRoutes.root,
              (route) => false,
            )
          : locator.app.navigation.pushNamedAndRemoveUntil(
              ModulesRoutes.login,
              (route) => false,
            ),
      child: MaterialApp(
        title: 'Edu',
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        theme: ThemeData(brightness: theme.brightness),
        scrollBehavior: const NoIndicatorsScrollBehaviour(),
        builder: (context, child) {
          final page = kDebugMode
              ? Stack(
                  children: [
                    Positioned.fill(child: child ?? const SizedBox.shrink()),
                    const DebugButton(),
                  ],
                )
              : child ?? const SizedBox.shrink();

          return AnimatedEduTheme(
            data: theme,
            child: RepositoryProvider<S>.value(
              value: S.of(context) ?? (throw const NoElementInContextException<S>()),
              child: UnFocusHandler(
                child: page,
              ),
            ),
          );
        },
        navigatorKey: locator.app.navigation.navigationKey,
        initialRoute: ModulesRoutes.initialRouteBuilder(context),
        onGenerateRoute: ModulesRoutes.onGenerateRoute,
      ),
    );
  }
}