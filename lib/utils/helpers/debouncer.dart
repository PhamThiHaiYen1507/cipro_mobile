import 'dart:async';
import 'dart:ui';

class Debouncer {
  Timer? _timer;
  final int waitForMs;

  Debouncer({this.waitForMs = 500});

  void debouncing({required VoidCallback fn, int? waitForMs}) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: waitForMs ?? this.waitForMs), fn);
  }

  void cancel() {
    _timer?.cancel();
  }
}
