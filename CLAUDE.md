# fashion-app

A fashion e-commerce demo app built with **Flutter**, for **educational purposes**. The goal is to
demonstrate core mobile app patterns clearly and simply — not to build a production-grade app.
Favor readable, teachable code over clever abstractions.

## Status

Project is not yet scaffolded. No `pubspec.yaml` / Flutter project exists in this repo yet — this
file documents the intended stack and conventions so future work stays consistent from the first
commit onward.

## Tech stack & key decisions

- **Framework:** Flutter (Dart)
- **State management:** `setState` only — no state management package (Provider/Riverpod/Bloc).
  Keep state as local to each widget as possible; lift it up via constructor params / callbacks
  when a couple of sibling widgets need to share it. This is a deliberate simplicity choice for
  teaching — don't introduce a state package without checking with the user first.
- **Navigation:** Navigator 2.0, implemented manually (`Router`, `RouterDelegate`,
  `RouteInformationParser`) — no `go_router` or other routing package. This is meant to teach the
  underlying navigation mechanics explicitly.
- **Backend / data:** A gRPC service written in Go, run locally by the user during development
  (not deployed, not part of this repo). The Flutter app is a gRPC client against it.
  - Client-side: use `package:grpc` (grpc-dart) with code generated from `.proto` files via
    `protoc` + the Dart protoc plugin.
  - The `.proto` files live in the Go service's repo, not here. When wiring up a new gRPC call,
    ask the user for the current `.proto` definitions / service address if they aren't already
    checked into this repo (e.g. under `proto/`).
  - Assume the service runs on `localhost` on a port the user provides — don't hardcode a guessed
    host/port without confirming.
  - Because the backend isn't always running, prefer building UI against fake/in-memory data first
    when the service isn't available, then wire up the real gRPC calls.

## Intended project structure

```
lib/
  main.dart
  app/                 # Router, RouterDelegate, RouteInformationParser, top-level App widget
  screens/             # One folder per screen/feature (e.g. catalog/, product_detail/, cart/, checkout/)
  widgets/             # Small reusable widgets shared across screens
  models/              # Plain Dart data classes (product, cart item, order, ...)
  services/            # gRPC client setup + generated pb/grpc code (services/grpc/generated/)
  utils/                # Formatting, constants, theme
test/
  widget tests mirroring lib/ structure
proto/                 # (optional) copies of .proto files used to generate the gRPC client
```

Keep each screen's UI, and any screen-local helper widgets, together under `screens/<feature>/`.
Only promote a widget to `widgets/` once it's actually reused in more than one place.

## Conventions

- Follow [Effective Dart](https://dart.dev/effective-dart) style; run `dart format` and
  `dart analyze` before considering work done.
- Prefer `const` constructors wherever possible.
- Write doc comments (`///`) on public classes/methods per Effective Dart doc guidelines.
- Add a widget test for each new screen/widget that has real logic (not just static layout).
- This project has the `dart-flutter` plugin's skills available (widget tests, static analysis,
  layout fixes, responsive layout, JSON serialization, etc.) — use them for the matching tasks
  (e.g. `flutter-add-widget-test`, `dart-run-static-analysis`, `flutter-fix-layout-issues`).

## Commands (once the Flutter project is scaffolded)

```
flutter create .          # scaffold, if not already done
flutter pub get
flutter analyze
flutter test
flutter run
```

## Non-goals

- No production backend, CI/CD, or app-store release process — this is a learning/demo project.
- No auth/payment integration beyond what's needed to demonstrate the UI flow.
