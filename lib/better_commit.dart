import 'dart:async';
import 'dart:io';

import 'package:better_commit/src/spinner.dart';
import 'package:dcli/dcli.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

/// This function is used to commit the changes to the git repository.
/// It uses the Google Generative AI API to generate a commit
/// message based on the changes.
/// It then runs the git commit command with the generated message.
Future<int?> commit({String? commitMessage}) async {
  final resultDiffNameOnly =
      await Process.run('git', ['diff', '--staged', '--name-only']);
  if (resultDiffNameOnly.stdout.toString().trim().isEmpty) {
    print('🚫 Nothing to commit');
    return 1;
  }
  final apiKey = env['GOOGLE_API_KEY'];
  if (apiKey == null) {
    print('GOOGLE_API_KEY is not set');
    return 1;
  }
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: apiKey,
  );
  final spinner = Spinner()..start();

  final result = await Process.run('git', ['diff', '--staged']);
  final diffOutput = result.stdout.toString();

  final response = await model.generateContent([
    Content.text('''
You are an AI assistant tasked with generating meaningful Git commit messages based on code changes. The commit messages should adhere to Git best practices and use appropriate Gitmoji to categorize the type of change.

### Requirements:
1. **Emoji**: Start the commit message with a relevant emoji (Gitmoji) that describes the type of change. Use the following examples:
   - 🎨 For improving code structure or format.
   - 🐛 For fixing a bug.
   - ✨ For introducing new features.
   - 🚀 For deploying changes.
   - 🔒️ For fixing security issues.
   - 💄 For UI changes.
   - ♻️ For refactoring code.
   - 📝 For adding or updating documentation.

2. **Title**: Write a concise title no longer than 50 characters that briefly explains the code change. It should follow the format: 
   `[TAG] Short Description`

3. **Description**: Write a detailed description explaining what the change does and why it was made. This should be no longer than 72 characters per line.

4. **Command**: The output should be in the form of a Git command like:
git commit -m "EMOJI [TAG] Title" -m "Detailed description"

### Example:
If the changes involve updating the version number in a `pubspec.yaml` file, the commit should look like this:
git commit -m "🚀 [RELEASE] Update version in pubspec.yaml" -m "Update version from 1.0 to 1.1 in pubspec.yaml and format the file."

When using the custom message feature, incorporate the custom input into the final commit message.

Please generate the appropriate commit message for the following staged code changes:
$diffOutput

If the user provides a custom message, it will be:
$commitMessage

The result should be a runable command like this: git commit -m "title" -m "description"
Very important: send the result as a normal string(not code).
'''),
  ]);
  await spinner.stop();

  var command =
      response.text?.trim().replaceAll('```', '').replaceAll('\n', '');
  print('$command');
  final wantEdit = confirm(
    '👆 This is the generated commit, Do you want to edit it?',
    defaultValue: false,
  );

  if (wantEdit) {
    final tempFile =
        File('${Directory.systemTemp.path}/temp_better_command.txt');
    await tempFile.writeAsString('''$command''');
    showEditor(tempFile.path);
    command = await tempFile.readAsString();
    command = command.trim().replaceAll('```', '').replaceAll('\n', '');
    print(command);
    await tempFile.delete();
  }

  final commitConfirm = confirm(
    '✅ Commit generated. Do you want to proceed with this commit?',
    defaultValue: true,
  );
  if (!commitConfirm) {
    print('Commit aborted.');
    return 0;
  }

  final exitCode = run(command!);

  return exitCode;
}
