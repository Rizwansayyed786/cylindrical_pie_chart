# Publishing Guide for cylindrical_pie_chart

This guide will help you publish the `cylindrical_pie_chart` package to pub.dev.

## Prerequisites

1. **Dart/Flutter SDK**: Make sure you have Flutter installed
2. **pub.dev Account**: Create an account at [pub.dev](https://pub.dev)
3. **Google Account**: You'll need a Google account to publish

## Step 1: Update Package Information

Before publishing, update the following in `pubspec.yaml`:

1. **Update repository URLs**: Replace `yourusername` with your GitHub username
   ```yaml
   homepage: https://github.com/yourusername/cylindrical_pie_chart
   repository: https://github.com/yourusername/cylindrical_pie_chart
   issue_tracker: https://github.com/yourusername/cylindrical_pie_chart/issues
   ```

2. **Add author information** (optional but recommended):
   ```yaml
   authors:
     - Your Name <your.email@example.com>
   ```

## Step 2: Create GitHub Repository (Recommended)

1. Create a new repository on GitHub named `cylindrical_pie_chart`
2. Initialize git in your package directory:
   ```bash
   cd "E:\flutter Projects\cylindrical_pie_chart"
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/yourusername/cylindrical_pie_chart.git
   git push -u origin main
   ```

## Step 3: Verify Package

Run the following commands to verify your package:

```bash
cd "E:\flutter Projects\cylindrical_pie_chart"

# Format code
dart format .

# Analyze code
flutter analyze

# Run tests (if you have any)
flutter test

# Check package for issues
flutter pub publish --dry-run
```

The `--dry-run` flag will check your package without actually publishing it.

## Step 4: Fix Any Issues

If `flutter pub publish --dry-run` reports any issues, fix them:

- **Missing LICENSE file**: Already included
- **Missing CHANGELOG.md**: Already included
- **Missing README.md**: Already included
- **Code formatting**: Run `dart format .`
- **Analysis issues**: Fix any warnings or errors

## Step 5: Login to pub.dev

```bash
dart pub login
```

This will open a browser window for you to authenticate with your Google account.

## Step 6: Publish the Package

Once everything is ready:

```bash
flutter pub publish
```

**Important Notes:**
- Publishing is **permanent** - you cannot delete packages from pub.dev
- You can publish new versions, but the version number must be higher
- Make sure you're ready before running this command!

## Step 7: Verify Publication

After publishing, check your package at:
```
https://pub.dev/packages/cylindrical_pie_chart
```

## Updating the Package

To publish a new version:

1. Update the version in `pubspec.yaml`:
   ```yaml
   version: 1.0.1  # Increment version number
   ```

2. Update `CHANGELOG.md` with the changes

3. Run verification:
   ```bash
   flutter pub publish --dry-run
   ```

4. Publish:
   ```bash
   flutter pub publish
   ```

## Package Name Availability

Before publishing, check if the name `cylindrical_pie_chart` is available:
- Visit: https://pub.dev/packages/cylindrical_pie_chart
- If it shows "404", the name is available
- If it shows a package, you'll need to choose a different name

If the name is taken, update `pubspec.yaml` with a different name like:
- `cylindrical_pie_chart_widget`
- `flutter_cylindrical_chart`
- `custom_cylindrical_pie_chart`

## Troubleshooting

### "Package name already taken"
Choose a different name and update `pubspec.yaml`

### "Authentication failed"
Make sure you're logged in: `dart pub login`

### "Package validation failed"
Run `flutter pub publish --dry-run` to see specific issues

### "Version already exists"
Increment the version number in `pubspec.yaml`

## Additional Resources

- [pub.dev Publishing Guide](https://dart.dev/tools/pub/publishing)
- [Package Layout Conventions](https://dart.dev/tools/pub/package-layout)
- [pub.dev Package Policy](https://pub.dev/policy)

Good luck with your publication! 🚀

