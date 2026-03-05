![Easy-Measure](https://socialify.git.ci/samyakrajgruhi/Easy-Measure/image?font=Raleway&language=1&name=1&owner=1&pattern=Solid&theme=Dark)

# ✂️ EasyMeasure

**EasyMeasure** is a cross-platform Flutter application for tailors and dressmakers to manage customer profiles and store detailed body measurements — all offline, all in one place.

---

## Features

- **Customer Management** — Add, edit, and delete customer profiles with name and phone number.
- **Comprehensive Measurements** — Record 25+ standard upper and lower body measurements per customer.
- **Custom Fields** — Add any additional measurement fields beyond the standard set.
- **Multiple Measurement Sets** — Store multiple named measurement records per customer (e.g., different outfits or dates).
- **Fuzzy Search** — Quickly find customers by name with fuzzy matching.
- **Swipe to Delete** — Dismissible UI for removing customers and measurements with a confirmation dialog.
- **Offline-First** — All data is persisted locally using Hive; no internet connection required.
- **Cross-Platform** — Runs on Android, iOS, Web, Linux, macOS, and Windows.

---

## Project Structure

```
lib/
├── main.dart                   # App entry point, Hive initialization
├── components/
│   ├── dismissible_plate.dart  # Swipe-to-delete wrapper widget
│   ├── input_field.dart        # Reusable labeled text input
│   └── name_plate.dart         # Customer name/phone display card
├── models/
│   ├── customer.dart           # Customer Hive model
│   └── measurement.dart        # Measurement Hive model
├── pages/
│   ├── flashScreen.dart        # Splash screen
│   ├── homePage.dart           # Customer list with search
│   ├── customerDetails.dart    # Customer profile + measurements list
│   ├── addCustomerPage.dart    # Add new customer form
│   ├── addMeasurementPage.dart # Add new measurement form
│   └── measurementDetails.dart # View/edit a single measurement
├── services/
│   └── storage_service.dart    # Hive CRUD operations
└── theme/
    └── theme.dart              # App-wide color constants
```

---

## Getting Started

### Prerequisites

- Flutter SDK `^3.10.7` — [Install Flutter](https://docs.flutter.dev/get-started/install)
- Dart SDK (bundled with Flutter)

### Installation

```bash
# Clone the repository
git clone https://github.com/your-username/easymeasure.git
cd easymeasure

# Install dependencies
flutter pub get

# Run code generation (for Hive adapters)
dart run build_runner build --delete-conflicting-outputs
```

### Running the App

```bash
flutter run                   # Default connected device
flutter run -d chrome         # Web (Chrome)
flutter run -d linux          # Linux desktop
flutter run -d android        # Android device/emulator
```

### Running Tests

```bash
flutter test
```

### Building for Release

```bash
flutter build apk             # Android APK
flutter build appbundle       # Android App Bundle
flutter build ios             # iOS (requires macOS)
flutter build web             # Web
flutter build linux           # Linux
flutter build windows         # Windows
flutter build macos           # macOS (requires macOS)
```

---

## Code Generation

This project uses `hive_generator` to generate type adapters for Hive models. Run this whenever a model changes:

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
