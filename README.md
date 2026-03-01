# myapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Web debugging (CORS)

When running the app in Chrome for web, use this to avoid CORS while debugging:

```bash
flutter run -d chrome --web-browser-flag "--disable-web-security"
```

**Use only for local debugging** — do not disable web security in production.
