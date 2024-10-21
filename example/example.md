# Cookbook

## Usage

Now you're ready to use Better Commit! Simply stage your changes and run:

```bash
git add .
better-commit
```

The AI will analyze your changes and generate a commit message for you.

## Custom Commit Messages

### Suggest a message for AI

If you want to provide additional context for the AI, you can use the `-sm "Your suggested message"`.
Or use `--suggest-message` flag:

```bash
better-commit -sm "You'r suggested message"
better-commit --suggest-message
```

### Force to use your message (just add tag and emoji)

If you wan't to FORCE AI to use your commit message, use `-fm "You'r force message"`.
Or use `--force-message` flag:

```bash
better-commit -fm "You'r force message"
better-commit --force-message
```
