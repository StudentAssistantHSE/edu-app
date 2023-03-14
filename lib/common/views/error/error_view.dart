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
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          ScreenGrid(
            column: 0,
            additionalOffset: 8,
            child: Builder(
              builder: (context) {
                final theme = Theme.of(context);
                return Text(
                  controller.titleSelector(context.watch<S>()),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.onSurfaceSwatch.shade700,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
          Builder(
            builder: (context) {
              final translation = controller.subtitleSelector(context.watch<S>());
              if (translation == null) {
                return const SizedBox.shrink();
              }
              final theme = Theme.of(context);
              return ScreenGrid(
                column: 0,
                additionalOffset: 8,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    translation,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 128, maxWidth: 128),
                child: ErrorImage(type: controller.type),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Builder(
            builder: (context) => PrimaryButton(
              text: controller.tryAgainButtonTextSelector(context.watch<S>()),
              style: PrimaryButtonStyle.elevated,
              onPressed: () => controller.onTryAgainButtonTap(context),
            ),
          ),
        ],
      ),
    ),
  );
}