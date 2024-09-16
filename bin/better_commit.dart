import 'dart:io';

import 'package:better_commit/better_commit.dart' as better_commit;
import 'package:dcli/dcli.dart';

void main(List<String> arguments) async {
  print(' ');
  print('🚀 Better Commit 🤖 Using Gemini 1.5 Flash model');
  String? commitMessage;
  if (arguments.contains('--custom')) {
    commitMessage = ask('📝 Enter your commit message (optional):');
  }
  final result = await better_commit.commit(commitMessage: commitMessage);
  exit(result ?? 1);
}
