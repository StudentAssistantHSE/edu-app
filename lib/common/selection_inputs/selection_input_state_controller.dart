import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';

abstract class SelectionInputStateController<Event, State, K> {
  const SelectionInputStateController();

  String? hintSelector(S translations) => null;
  List<SelectionInputItem<K>> itemsSelector(S translations, State state);
  K? selectedItemSelector(State state) => null;
  bool disabledSelector(State state) => false;

  bool itemsChangedChecker(State previous, State current) => false;

  Event? eventBuilder(BuildContext context, K? value) => null;
}