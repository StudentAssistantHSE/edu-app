import 'package:edu_core/edu_core.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_authentication/feature_authentication.dart';
import 'package:feature_settings/feature_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebugView extends StatelessWidget {
  const DebugView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => EduScaffold(
    appBar: EduAppBar(
      leading: const EduAppBarBackButton(),
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Theme'),
          const SizedBox(height: 8),
          Builder(
            builder: (context) => DropdownInput<ThemeType>(
              selectedItem: context.select<SettingsBloc, ThemeType>((value) => value.state.settings.themeType),
              hint: 'Platform',
              items: const [
                DropdownInputItem(key: ThemeType.platform, title: 'Platform'),
                DropdownInputItem(key: ThemeType.light, title: 'Light'),
                DropdownInputItem(key: ThemeType.dark, title: 'Dark'),
                DropdownInputItem(key: ThemeType.blue, title: 'Blue'),
              ],
              onChanged: (theme) => theme == null ? null : context.read<SettingsBloc>().add(SettingsThemeTypeChanged(theme)),
            ),
          ),
          const SizedBox(height: 8),
          EduGradientButton(
            text: 'Logout',
            onPressed: () => context.read<AuthenticationBloc>().add(const AuthenticationLoggedOut()),
          ),
        ],
      ),
    ),
  );
}