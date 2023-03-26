import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';

class AppBarContent extends StatelessWidget {
  const AppBarContent({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(24),
    child: LayoutBuilder(
      builder: (context, constraints) {
        final logoSize = Size(
          constraints.maxWidth * 0.36,
          constraints.maxHeight * 0.32,
        );
        return Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            const Positioned.fill(child: Firework(color: ColorSchemeReference.primary300)),
            Positioned(
              width: logoSize.shortestSide,
              height: logoSize.shortestSide,
              child: const EduLogo(),
            ),
          ],
        );
      },
    ),
  );
}