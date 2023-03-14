import 'package:edu_app/common/texts/text_state_controller.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageTitleTextWidget extends StatelessWidget {
  final TextStateController controller;

  const PageTitleTextWidget({ required this.controller, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        context.select<S, String>(controller.textSelector).toUpperCase(),
        style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
      ),
    );
  }
}