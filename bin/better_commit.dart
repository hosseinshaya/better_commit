import 'dart:io';

import 'package:better_commit/better_commit.dart' as better_commit;
import 'package:dcli/dcli.dart';

void main(List<String> arguments) {
  final commitMessage = ask('📝 Enter your commit message (optional):');
  final result = better_commit.commit(commitMessage: commitMessage);
  exit(result ?? 1);
}
