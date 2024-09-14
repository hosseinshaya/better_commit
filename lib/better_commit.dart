import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

/// This function is used to commit the changes to the git repository.
/// It uses the Google Generative AI API to generate a commit
/// message based on the changes.
/// It then runs the git commit command with the generated message.
Future<int?> commit({String? commitMessage}) async {
  final apiKey = env['GOOGLE_API_KEY'];
  if (apiKey == null) {
    print('GOOGLE_API_KEY is not set');
    return 1;
  }
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: apiKey,
  );
  final result = await Process.run('git', ['diff', '--staged']);
  final diffOutput = result.stdout.toString();

  final response = await model.generateContent([
    Content.text(
        // ignore: leading_newlines_in_multiline_strings
        '''Write a short emoji commit message(max 70 characters) based on this changes: \n $diffOutput \n
        ${commitMessage == null ? '' : 'And based on this commit message: \n $commitMessage \n'}.
        Commit message format: emoji + space + [tag.toUpperCase()] + space + commit message'''),
  ]);
  print('🚀 git commit -m "${response.text?.trim()}"');
  final exitCode =
      run('git commit -m "${response.text?.trim()}"', runInShell: true);

  return exitCode;
}
