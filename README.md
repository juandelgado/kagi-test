NOTE: This repo is the deliverable for a Flutter dev role technical test for [Kagi](https://kagi.com/). [More info](./docs/test-instructions.md).

# Juan's Kite

<img width="600" src="images/dark.png"/>

Also available in [light theme](./images/light.png) and for [wide screens](images/wide-screen-layout.png). More examples in the [gallery](./docs/gallery.md).

# Development

Created using the [Very Good Ventures Starter App template](https://cli.vgv.dev/docs/templates/core).

Main libraries:

- [bloc](https://pub.dev/packages/flutter_bloc) for state management.
- [Beamer](https://pub.dev/packages/beamer) for routing.
- [Dio](https://pub.dev/packages/dio) for network requests.
- [json_serializable](https://pub.dev/packages/json_serializable) and [json_annotation](https://pub.dev/packages/json_annotation) to parse JSON responses.
- [intl](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization) for localization and internationalization.
- [mocktail](https://pub.dev/packages/mocktail) and [bloc_test](https://pub.dev/packages/bloc_test) for mocking and testing.

## Setup and configuration

Recommendations:

- Xcode through [Xcodes](https://www.xcodes.app/), then [Configure iOS development](https://docs.flutter.dev/get-started/install/macos/mobile-ios#configure-ios-development).
- [Android Studio](https://developer.android.com/studio), then [Configure Android development](https://docs.flutter.dev/get-started/install/macos/mobile-android#configure-android-development).
- Flutter `3.29.3` through [FVM](https://fvm.app/).
- [VSCode](https://code.visualstudio.com/) with the Flutter plugin.

Mobile development toolchains are never straight forward, but `flutter doctor` provides decent support for troubleshooting.

## Run

Juan's Kite app comes with 2 [flavours](https://docs.flutter.dev/deployment/flavors), `development` and `production`:

```sh
flutter run --flavor development --target lib/main_development.dart
flutter run --flavor production --target lib/main_production.dart
```

## Test

```sh
flutter test --coverage --test-randomize-ordering-seed random
```

## CI

On commits to and pull requests against the `main` branch:

- [Flutter Package](https://workflows.vgv.dev/docs/workflows/flutter_package): format, analyze, test and check coverage.
- [Semantic Pull Request](https://workflows.vgv.dev/docs/workflows/semantic_pull_request): checks for [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) and commit history.
- [Spell Check](https://workflows.vgv.dev/docs/workflows/spell_check).

## Accessibility

The app should be [accessible to screen readers](./images/accessibility.mp4) (video) and handle user system preferences for font sizes ([smallest](./images/smallest-font-size.png) and [biggest](./images/biggest-font-size.png)).

The tests for the views also run some basic accessibility checks as recommended in the [official documentation](https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility#testing-accessibility-on-mobile).
