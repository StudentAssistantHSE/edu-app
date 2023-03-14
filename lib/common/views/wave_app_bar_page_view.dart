import 'package:edu_app/common/views/scrollable_body_view.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';

class WaveAppBarPageView extends StatelessWidget {
  final List<Widget> children;
  final bool useScrollableBody;
  final bool automaticallyApplyLeading;
  final Widget? leading;

  const WaveAppBarPageView({
    this.children = const [],
    this.useScrollableBody = true,
    this.automaticallyApplyLeading = true,
    this.leading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => EduScaffold(
    waveAppBarSettings: WaveAppBarSettings(
      waveAppBar: const WaveAppBar(),
      automaticallyApplyLeading: automaticallyApplyLeading,
      leading: leading,
    ),
    resizeToAvoidBottomInset: false,
    useSafeArea: false,
    body: useScrollableBody
        ? ScrollableBodyView(children: children)
        : Column(children: children),
  );
}