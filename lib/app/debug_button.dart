import 'package:edu_app/di/locator.dart';
import 'package:edu_app/modules/modules_routes.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';

class DebugButton extends StatefulWidget {
  const DebugButton({ Key? key }) : super(key: key);

  @override
  _DebugButtonState createState() => _DebugButtonState();
}

class _DebugButtonState extends State<DebugButton> {
  double _offsetX = 20;
  double _offsetY = 20;

  @override
  Widget build(BuildContext context) => Positioned(
    right: _offsetX,
    top: _offsetY,
    child: Listener(
      onPointerMove: (details) => setState(() {
        _offsetX -= details.delta.dx;
        _offsetY += details.delta.dy;
        if (_offsetX <= 0) { _offsetX = 0; }
        if (_offsetY <= 0) { _offsetY = 0; }
        final size = MediaQuery.of(context).size;
        final boundX = size.width - 100;
        final boundY = size.height - 50;
        if (_offsetX >= boundX) { _offsetX = boundX; }
        if (_offsetY >= boundY) { _offsetY = boundY; }
      }),
      child: Material(
        borderRadius: BorderRadius.circular(4),
        child: EduGradientButton(
          text: 'DEBUG',
          expand: false,
          onPressed: () => locator.app.navigation.pushNamed(
            ModulesRoutes.debug,
          ),
        ),
      ),
    ),
  );
}