import 'dart:async';
import 'dart:io';

import 'package:edu_app/app/edu_app.dart';
import 'package:edu_app/di/injector.dart';
import 'package:edu_app/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  if (Settings.sentryUrl.isNotEmpty) {
    await SentryFlutter.init((options) {
      options
        ..dsn = Settings.sentryUrl
        ..release = Settings.version;
    },
      appRunner: _run,
    );
  } else {
    _run();
  }
}

void _run() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      if (Platform.isIOS) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
      }

      configureDependencies().then((_) => runApp(const EduApp()));
    },
    (error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: error.toString());
    },
  );
}