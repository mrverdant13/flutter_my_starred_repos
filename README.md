# Flutter app template

[![style: lint][lint_badge]][lint_package_link]

An app project template made with Flutter by [mrverdant13][mrverdant13_link].

---

## Features

### Platform-specific features

|                                           | Android | iOS | Web | Linux | Windows | MacOS |
| :---------------------------------------- | :-----: | :-: | :-: | :---: | :-----: | :---: |
| Native flavors                            |   ✔️    | ❌  | ➖  |  ➖   |   ➖    |  ➖   |
| Different app icon per flavor             |   ✔️    | ❌  | 🤔  |  🤔   |   🤔    |  🤔   |
| Different app splash per flavor           |   ✔️    | ❌  | 🤔  |  🤔   |   🤔    |  🤔   |
| Different app splash per dark/light theme |   ✔️    | 🤔  | 🤔  |  🤔   |   🤔    |  🤔   |
| App signing pre-configuration             |   ✔️    | 🤔  | 🤔  |  🤔   |   🤔    |  🤔   |
| Internationalization                      |   ❌    | ❌  | 🤔  |  🤔   |   🤔    |  🤔   |

| Tag | Description         |
| :-: | :------------------ |
| ✔️  | Supported           |
| ❌  | Not supported       |
| ➖  | Not applicable      |
| 🤔  | Under investigation |

### Project-wide features

- Flutter-level flavors by using different entry points per flavor.
- CI/CD:
  - GitHub Actions:
    - Code formatting
    - Code analysis
    - Unit testing
- GitHub issue templates.
- GitHub pull request template.
- Strong lint rules with the [lint package][lint_package_link].
- IDE launch setup:
  - Visual Studio Code

---

## Prerequisites

### Required

- [Flutter 2][flutter_link] to build and test the project.

### Optional

- [Chocolatey][chocolatey_link] on Windows to install and use `lcov` utils.
- [remove_from_coverage][remove_from_coverage_link] package to ignore generated files in coverage info.

---

## App flavors

This project supports 3 Flutter-level and native flavors (**Android only**) that can be used directly with the launch configuration in Visual Studio Code or by executing one of the following commands:

```sh
# Development
$ flutter run --flavor dev --target lib/main_dev.dart

# Staging
$ flutter run --flavor stg --target lib/main_stg.dart

# Production
$ flutter run --flavor prod --target lib/main_prod.dart
```

> **Note:** The target path separator (`\` or `/`) might change according to your OS.
>
> **Note:** The `--flavor` option only applies for Android and iOS platforms (at the moment, this project only supports Android flavoring). For other platforms, this option is ignored.

---

## Testing

1. To run all unit and widget tests, execute the following command:

   ```sh
   $ flutter test --coverage -r expanded --test-randomize-ordering-seed random
   ```

2. To remove generated files from coverage info, install the [remove_from_coverage package][remove_from_coverage_link] and run one of the following commands:

   ```sh
   # If pub global scripts are on your path
   $ remove_from_coverage -f coverage/lcov.info -r "\.freezed\.dart$","\.g\.dart$","\.gr\.dart$"

   # Otherwise (might change depending on pub setup)
   $ pub global run remove_from_coverage:remove_from_coverage -f coverage/lcov.info -r "\.freezed\.dart$","\.g\.dart$","\.gr\.dart$"
   ```

3. To generate coverage report within the `coverage` folder, run one of the following commands set according to your OS:

   ```sh
   # Linux/MacOS
   # Generate coverage report
   $ genhtml coverage/lcov.info -o coverage/html/

   # Windows
   # Install `lcov` utils (Chocolatey is prerequisite)
   $ choco install lcov
   # Generate coverage report (might change depending on Chocolatey setup)
   $ perl C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml -o coverage\html coverage\lcov.info
   ```

4. To open the generated coverage report, run one of the following commands according to your OS:

   ```sh
   # Linux/MacOS
   $ open coverage/html/index.html

   # Windows
   $ start coverage/html/index.html
   ```

---

## Issues

Submit a [new issue report][new_project_issues_link] if you find any bug or have any suggestion.

---

## References

- [Android official documentation][android_official_documentation_link]
- [Very Good CLI][very_good_cli_link]
- [Flutter official documentation][flutter_link]

<!-- LINKS -->

[android_official_documentation_link]: https://developer.android.com/
[chocolatey_link]: https://chocolatey.org/
[flutter_link]: https://flutter.dev/
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[lint_badge]: https://img.shields.io/badge/style-lint-4BC0F5.svg
[lint_package_link]: https://pub.dev/packages/lint
[mrverdant13_link]: https://github.com/mrverdant13/
[mrverdant13_flutter_project_template]: https://github.com/mrverdant13/flutter_app_template
[new_project_issues_link]: https://github.com/mrverdant13/git_history/issues/new/choose
[remove_from_coverage_link]: https://pub.dev/packages/remove_from_coverage
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
