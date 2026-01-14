# WeSplit - Flutter

A bill-splitting calculator built with Flutter, demonstrating rapid cross-platform development with a single codebase for iOS and Android.

## Overview

WeSplit calculates how to split a restaurant bill between multiple people, including tip. This implementation showcases Flutter's hot reload, widget composition, and the Material 3 design system.

**Part of a cross-platform comparison project** - the same app implemented in SwiftUI, Kotlin Multiplatform, and Flutter.

## Tech Stack

- **Flutter 3.16+** - Cross-platform UI framework
- **Dart 3.2+** - Programming language
- **Material 3** - Modern Material Design
- **intl package** - Internationalization and currency formatting

## Features

- ✅ Currency input with localized formatting
- ✅ Dynamic person count selection (2-99)
- ✅ Tip percentage selection with segmented buttons
- ✅ Real-time calculation
- ✅ Input validation with regex patterns
- ✅ Navigator push/pop pattern

## Getting Started

### Requirements
- Flutter SDK 3.16+
- Dart SDK 3.2+
- iOS Simulator or Android Emulator

### Installation

```bash
git clone https://github.com/[your-username]/wesplit-flutter.git
cd wesplit-flutter
flutter pub get
```

**Run on iOS:**
```bash
flutter run -d ios
```

**Run on Android:**
```bash
flutter run -d android
```

## Project Structure

```
we_split/
├── lib/
│   ├── main.dart                    # Main app & calculator (238 lines)
│   └── number_of_people_picker.dart # People picker widget
├── pubspec.yaml                     # Dependencies
└── README.md
```

## Implementation Highlights

- **StatefulWidget** - Lifecycle management with controllers
- **TextEditingController** - Manual text input handling
- **MaterialPageRoute** - Type-safe navigation with async/await
- **InputFormatters** - Regex-based input validation
- **intl package** - Consistent currency formatting

## Read More

📝 **[Building the Same App in SwiftUI, Kotlin Multiplatform, and Flutter](link-to-medium-article)**

A detailed comparison of implementing WeSplit across three frameworks, examining code metrics, architecture patterns, and developer experience.

## Related Projects

- [WeSplit - SwiftUI](https://github.com/simonbogutzky/wesplit-swiftui) - 75 lines
- [WeSplit - Kotlin Multiplatform](https://github.com/simonbogutzky/wesplit-kmp) - 281 lines

## Screenshots

![WeSplit Flutter Implementation](screenshot.png)

## License

MIT License - see [LICENSE](LICENSE) file for details

## Author

**Simon Bogutzky**  
- Medium: [@simonbogutzky](https://medium.com/@simonbogutzky)
- Senior iOS Engineer @ Open Reply Germany
