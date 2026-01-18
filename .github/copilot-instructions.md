# EasyMeasure - AI Agent Instructions

## Project Overview
EasyMeasure is a Flutter application supporting 6 platforms (Android, iOS, Web, Linux, macOS, Windows). This is a starter project with standard Flutter SDK 3.10.7+ structure.

## Project Structure
```
lib/
  main.dart          # App entry point with MyApp and MyHomePage
  pages/             # Feature pages (currently empty - new features go here)
test/
  widget_test.dart   # Widget tests using flutter_test
```

## Development Workflow

### Running the App
```bash
flutter run                    # Run on connected device/emulator
flutter run -d chrome          # Run on Chrome (web)
flutter run -d linux           # Run on Linux desktop
```

### Testing
```bash
flutter test                   # Run all tests
flutter test test/widget_test.dart  # Run specific test file
```

### Building
```bash
flutter build apk              # Android APK
flutter build ios              # iOS (macOS only)
flutter build web              # Web bundle
flutter build linux            # Linux executable
flutter build windows          # Windows executable (Windows only)
flutter build macos            # macOS app (macOS only)
```

### Hot Reload
- Use `r` in the terminal or save files to hot reload
- Use `R` for hot restart (resets app state)
- Hot reload preserves state, hot restart resets it completely

## Code Conventions

### State Management
- Uses StatefulWidget with setState() for local state management
- Private state classes follow `_WidgetNameState` naming convention
- Example: `MyHomePage` → `_MyHomePageState`

### Widget Structure
- Const constructors for immutable widgets: `const MyWidget({super.key})`
- Key parameter always included for widget identity tracking
- Stateless widgets use `const` constructor, stateful widgets accept parameters in constructor

### Theme & Styling
- Material Design with ColorScheme API: `ColorScheme.fromSeed(seedColor: ...)`
- Access theme via `Theme.of(context)` in build methods
- Use theme colors: `Theme.of(context).colorScheme.inversePrimary`

### File Organization
- New feature pages go in `lib/pages/`
- Import package with: `import 'package:easymeasure/main.dart'` (or specific file)
- Test files mirror lib structure: `lib/pages/foo.dart` → `test/pages/foo_test.dart`

## Dependencies
- **flutter_lints**: ^6.0.0 - Linting rules (see analysis_options.yaml)
- **cupertino_icons**: ^1.0.8 - iOS-style icons
- Minimal dependencies - add new ones via `flutter pub add package_name`

## Linting
- Uses `package:flutter_lints/flutter.yaml` recommended rules
- Lint configuration in `analysis_options.yaml`
- Run `flutter analyze` to check for issues

## Platform-Specific Code
Each platform has its own directory with native build configurations:
- **android/**: Kotlin Gradle build files
- **ios/**: Xcode project (Swift)
- **linux/**, **windows/**, **macos/**: CMake projects with C++ runner code
- **web/**: HTML entry point and manifest

Modify platform-specific code only when adding native integrations or platform-specific features.

## Testing Pattern
Widget tests use `WidgetTester` for interaction simulation:
```dart
await tester.pumpWidget(const MyApp());  // Build widget tree
await tester.tap(find.byIcon(Icons.add)); // Simulate tap
await tester.pump();                      // Rebuild after state change
expect(find.text('1'), findsOneWidget);  // Verify result
```

## Current App State
The app is a counter demo with:
- AppBar with title
- Center column with counter display
- FloatingActionButton to increment counter
- Uses deep purple theme with Material Design 3

New features should replace or extend this demo structure in `lib/pages/`.
