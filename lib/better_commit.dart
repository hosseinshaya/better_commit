import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

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
  final result = Process.runSync('git status', []);
  final output = result.stdout.toString();

  // final response = await model.generateContent([
  //   Content.text(
  //       'Write a short emoji commit message based on this changes: ${run}')
  // ]);
  // final exitCode = run('git commit -m "$commitMessage"');
  // return exitCode;
  return 0;
}
