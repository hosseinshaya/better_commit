import 'dart:async';
import 'dart:io';

class Spinner {
  Spinner();
  static const List<String> _spinnerEmojis = ['⠋', '⠙', '⠹', '⠿'];

  bool _isSpinning = false;
  final Completer<void> _stopCompleter = Completer<void>();
  Future<void>? spinnerFuture;

  Future<void> start() {
    _isSpinning = true;
    var index = 0;

    Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
      if (!_isSpinning) {
        timer.cancel();
        _stopCompleter.complete();
        _clearLine();
        return;
      }

      stdout.write('\rLoading ${_spinnerEmojis[index]}');
      index = (index + 1) % _spinnerEmojis.length;
    });

    spinnerFuture = _stopCompleter.future;
    return _stopCompleter.future;
  }

  Future<void> stop() async {
    _isSpinning = false;
    await spinnerFuture;
  }

  void _clearLine() {
    stdout.write(
      '\r${' ' * 20}\r',
    );
  }
}
