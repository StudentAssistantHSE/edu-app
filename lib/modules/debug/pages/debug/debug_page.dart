import 'package:edu_app/modules/debug/pages/debug/view/debug_view.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';

part 'debug_page_arguments.dart';

class DebugPage extends BasePage<DebugPageArguments> {
  const DebugPage({ Key? key }) : super(
    view: const DebugView(),
    key: key,
  );
}