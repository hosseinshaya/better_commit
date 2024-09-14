import 'package:dcli/dcli.dart';

int? commit({String? commitMessage}) {
  final exitCode = run('git commit -m "$commitMessage"');
  return exitCode;
}
