import 'package:better_commit/better_commit.dart' as better_commit;
import 'package:dcli/dcli.dart';

void main(List<String> arguments) {
  String name = ask('Enter your name:');
  print('Hello $name: ${better_commit.calculate()}!');
}
