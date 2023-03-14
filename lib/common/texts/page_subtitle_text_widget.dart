import 'package:edu_app/common/texts/text_state_controller.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageSubtitleTextWidget extends StatelessWidget {
  final TextStateController controller;

  const PageSubtitleTextWidget({ required this.controller, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
    context.select<S, String>(controller.textSelector),
    style: Theme.of(context).textTheme.bodySmall,
    textAlign: TextAlign.center,
  );
}