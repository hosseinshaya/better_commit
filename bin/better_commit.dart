import 'dart:io';

import 'package:better_commit/better_commit.dart' as better_commit;
import 'package:dcli/dcli.dart';

void main(List<String> arguments) async {
  print('🚀 Better Commit 🤖 Using Gemini 1.5 Flash model');

  String? suggestMessage;
  if (arguments.contains('-sm')) {
    final messageIndex = arguments.indexOf('-sm') + 1;
    if (arguments.length > messageIndex &&
        arguments[messageIndex].trim().isNotEmpty) {
      suggestMessage = arguments[messageIndex].replaceAll('"', '');
    } else {
      suggestMessage =
          ask('📝 Enter your suggested commit message (optional):');
    }
  } else if (arguments.contains('--custom') ||
      arguments.contains('--suggest-message')) {
    if (arguments.contains('--custom')) {
      print('🚨 --custom is deprecated, use --suggest-message instead');
    }
    suggestMessage = ask('📝 Enter your suggested commit message (optional):');
  }

  String? forceMessage;
  if (arguments.contains('-fm')) {
    final messageIndex = arguments.indexOf('-fm') + 1;
    if (arguments.length > messageIndex &&
        arguments[messageIndex].trim().isNotEmpty) {
      forceMessage = arguments[messageIndex].replaceAll('"', '');
    } else {
      forceMessage = ask('📝 Enter your force commit message (optional):');
    }
  } else if (arguments.contains('--force-message')) {
    forceMessage = ask('📝 Enter your force commit message (optional):');
  }

  final result = await better_commit.commit(
    suggestMessage: suggestMessage,
    forceMessage: forceMessage,
  );
  exit(result ?? 1);
}
