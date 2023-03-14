import 'package:edu_app/common/selection_inputs/selection_input_state_controller.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectionInputWidget<T extends Bloc<Event, State>, Event, State, K> extends StatelessWidget {
  final SelectionInputStateController<Event, State, K> controller;

  const SelectionInputWidget({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<T, State>(
    buildWhen: (previous, current) {
      final previousSelected = controller.selectedItemSelector(previous);
      final currentSelected = controller.selectedItemSelector(current);
      final previousDisabled = controller.disabledSelector(previous);
      final currentDisabled = controller.disabledSelector(current);
      return previousSelected != currentSelected
          || previousDisabled != currentDisabled
          || controller.itemsChangedChecker(previous, current);
    },
    builder: (context, state) {
      final hint = context.select<S, String?>(controller.hintSelector);
      final items = context.select<S, List<SelectionInputItem<K>>>(
        (translations) => controller.itemsSelector(translations, state),
      );
      final selectedItem = controller.selectedItemSelector(state);
      final disabled = controller.disabledSelector(state);
      return SelectionInput<K>(
        items: items,
        selectedItem: selectedItem,
        hint: hint,
        onChanged: disabled ? null : (value) {
          final event = controller.eventBuilder(context, value);
          if (event != null) {
            context.read<T>().add(event);
          }
        },
      );
    },
  );
}