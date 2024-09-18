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
You are an AI assistant tasked with generating meaningful Git commit messages based on code changes. The commit messages should follow Git best practices and include appropriate Gitmoji.

### Requirements:

1. **Emoji**: Start the commit message with a relevant Gitmoji to describe the type of change.
   - 🎨 Improving code structure/format.
   - 🐛 Fixing a bug.
   - ✨ Introducing new features.
   - 🚀 Deploying changes.
   - 🔒️ Fixing security issues.
   - 💄 UI changes.
   - ♻️ Refactoring code.
   - 📝 Documentation updates.
   
2. **Title**: Provide a concise title (max 50 characters) that follows the format: `[TAG] Short Description`.

3. **Description**: Write a detailed description (max 72 characters per line) explaining what the change does and why it was made.

4. **Command Output**: Produce the final Git command in the format: 
`git commit -m "EMOJI [TAG] Title" -m "Detailed description"`

### Example:
If updating the version number in a `pubspec.yaml` file, the commit should be:
`git commit -m "🚀 [RELEASE] Update version in pubspec.yaml" -m "Update version from 1.0 to 1.1 in pubspec.yaml and format the file"`

### Task:
1. Diff Output - Generate an appropriate commit message for the following staged code changes:
$diffOutput

2. Custom Message - If a custom commit message is provided, integrate it into the final commit:
$commitMessage

### Conditions:
- **With Custom Message**: Prefer the custom message for title and just fix text and add emoji and tag. also write description based on diff output.
- **Without Custom Message**: Generate the commit message entirely based on the diff output.

The result should be a runnable Git command string.
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
