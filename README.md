# Better Commit

## Let's AI write a Better Commit ✨

[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

Better Commit is a Dart package that uses AI to generate meaningful commit messages based on your code changes.

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

```bash
export GOOGLE_API_KEY="your_api_key"
```

### 3. Let the Magic Work

Now you're ready to use Better Commit! Simply stage your changes and run:

```bash
better_commit
```

The AI will analyze your changes and generate a commit message for you.

## Custom Commit Messages

If you want to provide additional context for the AI, you can use the `--custom` flag:

```bash
better_commit --custom
```

This will prompt you to enter an optional commit message, which the AI will consider when generating the final commit message.

## How It Works

Better Commit uses the Gemini 1.5 Flash model to analyze your staged changes and generate a concise, meaningful commit message. It follows the format:

emoji [TAG] commit message

Enjoy writing better commits with AI assistance!
