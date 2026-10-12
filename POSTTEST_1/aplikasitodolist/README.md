# Karsa

A Flutter todo app with a warm, cafe-inspired interface.

## State management

`TugasProvider` is the single source of truth for task data. It extends
`ChangeNotifier` and is provided above the app with `ChangeNotifierProvider`.
The home, task, detail, and profile screens observe the same provider, so adding
or completing a task immediately updates every screen.

The home screen uses a `StatefulWidget` for temporary UI state such as the
search query and selected filter. Task data is shared through Provider instead
of being kept in individual pages.

## Run

```sh
flutter pub get
flutter run
```
