import 'package:flutter/widgets.dart';

typedef VoidStateCallback<State> = void Function(BuildContext context, State state);
typedef StringEventBuilder<Event> = Event Function(String value);