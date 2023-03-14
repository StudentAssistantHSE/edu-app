import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';

class ScrollableBodyView extends StatelessWidget {
  final List<Widget> children;
  final bool useTopPadding;

  const ScrollableBodyView({
    this.children = const [],
    this.useTopPadding = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final padding = ScreenGrid.getPadding(
      screenWidth: mediaQuery.size.width,
      column: 0,
      additionalOffset: 32,
    );

    return ListView(
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        padding,
        useTopPadding ? 36 : 0,
        padding,
        mediaQuery.viewInsets.bottom + 24,
      ),
      children: children,
    );
  }
}