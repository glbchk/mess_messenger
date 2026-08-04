import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToggleNotifier extends Notifier<bool> {
  final bool initialValue;
  ToggleNotifier({this.initialValue = false});

  @override
  bool build() => initialValue;

  void set(bool value) => state = value;
  void toggle() => state = !state;
}

final loginSwitchProvider = NotifierProvider<ToggleNotifier, bool>(
  ToggleNotifier.new,
);
final photoCheckboxProvider = NotifierProvider<ToggleNotifier, bool>(
  ToggleNotifier.new,
);
final audioCheckboxProvider = NotifierProvider<ToggleNotifier, bool>(
  ToggleNotifier.new,
);
final videoCheckboxProvider = NotifierProvider<ToggleNotifier, bool>(
  ToggleNotifier.new,
);
final documentCheckboxProvider = NotifierProvider<ToggleNotifier, bool>(
  ToggleNotifier.new,
);
