import 'package:edu_app/modules/registration/pages/finish_registration/view/app_bar_content.dart';
import 'package:edu_app/modules/registration/pages/finish_registration/view/controllers.dart';
import 'package:edu_app/modules/registration/pages/finish_registration/view/start_button.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';

class FinishRegistrationView extends StatelessWidget {
  const FinishRegistrationView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => EduScaffold(
    waveAppBarSettings: const WaveAppBarSettings(
      waveAppBar: WaveAppBar(
        keyboardCollapsedSize: 0.64,
        collapseWhenKeyboardOpened: false,
        title: AppBarContent(),
      ),
      leading: EduAppBarBackButton(),
    ),
    body: Column(
      children: const [
        SizedBox(height: 40),
        Center(
          child: TextWidget(
            textStyle: TextThemeReference.pageTitle,
            controller: PageTitleTextController(),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 8),
        Center(
          child: TextWidget(
            textStyle: TextThemeReference.caption,
            controller: PageSubtitleTextController(),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 24),
        StartButton(),
      ],
    ),
  );
}