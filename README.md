# Better Commit

![Frame 11741](https://github.com/user-attachments/assets/53d933f9-8205-4d52-8ffa-8fb6bf013bc1)

[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)
[![Last Commits](https://img.shields.io/github/last-commit/hosseinshaya/better_commit?logo=git&logoColor=white)](https://github.com/hosseinshaya/better_commit/commits/main)
[![Uploaded By](https://img.shields.io/badge/Uploaded%20by-Hossein%20Shaya-blue)](https://github.com/hosseinshaya)
[![GitHub stars](https://img.shields.io/github/stars/hosseinshaya/better_commit.svg?style=social&label=Stars)](https://github.com/hosseinshaya/better_commit)

Better Commit is a Dart package that uses AI to generate meaningful commit messages based on your code changes.

❌ Before 🤮

```bash
git commit -m "update version"
```

✅ After 😎

```bash
git commit -m "🚀 [RELEASE] Update version to 1.4.0" -m "Update version number in pubspec.yaml and changelog."
```

## Installation

To install Better Commit globally, run the following command:

```bash
dart pub global activate better_commit
```

## Getting Started

### 1. Get an API Key

Using the Google AI Dart SDK requires an API key. Follow the instructions at [https://ai.google.dev/tutorials/setup](https://ai.google.dev/tutorials/setup) to create one.

### 2. Set the API Key

Set your API key as an environment variable:

#### For Linux and MacOS

```bash
export GOOGLE_API_KEY="your_api_key"
```

To add this forever you can add it to:
~/.zshrc or ~/.bashrc

#### For Windows

```cmd
set GOOGLE_API_KEY=your_api_key
```

To add this forever you can add it to:
Environment Variables in System Properties

### 3. Let the Magic Work

Now you're ready to use Better Commit! Simply stage your changes and run:

```bash
git add .
better-commit
```

The AI will analyze your changes and generate a commit message for you.

## Custom Commit Messages

If you want to provide additional context for the AI, you can use the `--custom` flag:

```bash
better-commit --custom
```

This will prompt you to enter an optional commit message, which the AI will consider when generating the final commit message.
Using custom flag, You can provide a simple and short message and ai will complete it.

## How It Works

Better Commit uses the Gemini 1.5 Flash model to analyze your staged changes and generate a concise, meaningful commit message. It follows the format:

emoji [TAG] commit message

Enjoy writing better commits with AI assistance!

## Contributing and Support

🤝 Pull Requests Welcome!

We value community contributions and are always looking to improve Better Commit. If you have ideas or improvements, feel free to submit a pull request!

⭐ Show Your Support

If you find Better Commit helpful, consider showing your support:

1. Star our [GitHub repository](https://github.com/hosseinshaya/better_commit) to help others discover the project.
2. Like the package on pub.dev to boost its visibility in the Dart community.

Your support motivates me to continue updating and enhancing this CLI tool. Every star and like makes a difference!

## 📞 Contact

If you have any questions, suggestions, or just want to connect, feel free to reach out:

- LinkedIn: [linkedin.com/in/hosseinshaya](https://linkedin.com/in/hosseinshaya)
- GitHub: [github.com/hosseinshaya](https://github.com/hosseinshaya)

- Banner Designer: [linkedin.com/in/mehdishabani98](https://linkedin.com/in/mehdishabani98)
