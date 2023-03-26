import 'package:edu_app/common/views/error/controllers.dart';
import 'package:edu_app/common/views/error/error_view_controller.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorView extends StatelessWidget {
  final ErrorViewController controller;

  const ErrorView({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox.expand(
    child: Padding(
      padding: EdgeInsets.symmetric(
        vertical: 32,
        horizontal: ScreenGrid.getPadding(screenWidth: 32, column: 0),
      ),
      child: Column(
        children: [
          Center(
            child: TextWidget(
              controller: ErrorTitleController(controller),
              textStyle: TextThemeReference.title,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: TextWidget(
              controller: ErrorSubtitleController(controller),
              textStyle: TextThemeReference.body,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ErrorImage(type: controller.type),
          ),
          const SizedBox(height: 24),
          Builder(
            builder: (context) => EduOutlinedButton(
              text: controller.tryAgainButtonTextSelector(context.watch<S>()),
              onPressed: () => controller.onTryAgainButtonTap(context),
              expand: false,
            ),
          ),
        ],
      ),
    ),
  );
}