import 'package:edu_app/common/common.dart';
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
        keyboardClosedSize: 0.64,
        collapseWhenKeyboardOpened: false,
        title: AppBarContent(),
      ),
      leading: EduAppBarBackButton(rootNavigator: true),
    ),
    body: Column(
      children: const [
        SizedBox(height: 28),
        PageTitleTextWidget(controller: PageTitleTextController()),
        SizedBox(height: 8),
        PageSubtitleTextWidget(controller: PageSubtitleTextController()),
        SizedBox(height: 24),
        StartButton(),
      ],
    ),
  );
}