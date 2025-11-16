# Setup Guide - HR Management System

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Development Environment Setup](#development-environment-setup)
3. [Project Setup](#project-setup)
4. [Configuration](#configuration)
5. [Running the Application](#running-the-application)
6. [Building for Production](#building-for-production)
7. [Troubleshooting](#troubleshooting)

## Prerequisites

### Required Software

1. **Flutter SDK** (>= 3.10.0)
   - Download from: https://flutter.dev/docs/get-started/install
   - Verify installation: `flutter --version`

2. **Dart SDK** (>= 3.0.0)
   - Comes bundled with Flutter
   - Verify: `dart --version`

3. **Git**
   - Download from: https://git-scm.com/downloads
   - Verify: `git --version`

4. **IDE** (Choose one)
   - **Android Studio** (Recommended)
     - Download from: https://developer.android.com/studio
     - Install Flutter and Dart plugins
   - **VS Code**
     - Download from: https://code.visualstudio.com/
     - Install Flutter and Dart extensions

### Platform-Specific Requirements

#### For Android Development
- Android SDK (API level 21 or higher)
- Android Studio or Android SDK Command-line Tools
- Java Development Kit (JDK) 11 or higher

#### For iOS Development (macOS only)
- Xcode 14.0 or higher
- CocoaPods: `sudo gem install cocoapods`
- iOS Simulator or physical iOS device

#### For Web Development
- Chrome browser (for debugging)

#### For Desktop Development
- **Windows**: Visual Studio 2022 with C++ development tools
- **macOS**: Xcode with command-line tools
- **Linux**: Required libraries (see Flutter documentation)

## Development Environment Setup

### 1. Install Flutter

**Windows:**
```bash
# Download Flutter SDK and extract to C:\src\flutter
# Add to PATH: C:\src\flutter\bin

# Verify installation
flutter doctor
```

**macOS/Linux:**
```bash
# Download and extract Flutter SDK
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable

# Add to PATH (add to ~/.bashrc or ~/.zshrc)
export PATH="$PATH:$HOME/development/flutter/bin"

# Verify installation
flutter doctor
```

### 2. Configure Flutter

```bash
# Accept Android licenses
flutter doctor --android-licenses

# Enable web support
flutter config --enable-web

# Enable desktop support (optional)
flutter config --enable-windows-desktop  # Windows
flutter config --enable-macos-desktop    # macOS
flutter config --enable-linux-desktop    # Linux

# Check configuration
flutter doctor -v
```

### 3. IDE Setup

**Android Studio:**
1. Install Flutter plugin: File → Settings → Plugins → Search "Flutter"
2. Install Dart plugin (automatically installed with Flutter)
3. Restart Android Studio

**VS Code:**
1. Install Flutter extension
2. Install Dart extension
3. Reload VS Code

## Project Setup

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/hr_management_system.git
cd hr_management_system
```

### 2. Install Dependencies

```bash
# Get all packages
flutter pub get

# Verify dependencies
flutter pub outdated
```

### 3. Generate Code

The project uses code generation for dependency injection, JSON serialization, and more.

```bash
# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Watch for changes (development mode)
flutter pub run build_runner watch --delete-conflicting-outputs
```

### 4. Create Required Directories

```bash
# Create assets directories if they don't exist
mkdir -p assets/translations
mkdir -p assets/images
mkdir -p assets/icons
mkdir -p assets/fonts
mkdir -p assets/templates
```

### 5. Add Translation Files

Create `assets/translations/ar.json`:
```json
{
  "app_name": "نظام إدارة الموارد البشرية",
  "login": "تسجيل الدخول",
  "logout": "تسجيل الخروج",
  "employees": "الموظفين",
  "attendance": "الحضور",
  "leaves": "الإجازات",
  "payroll": "الرواتب"
}
```

Create `assets/translations/en.json`:
```json
{
  "app_name": "HR Management System",
  "login": "Login",
  "logout": "Logout",
  "employees": "Employees",
  "attendance": "Attendance",
  "leaves": "Leaves",
  "payroll": "Payroll"
}
```

## Configuration

### 1. API Configuration

Edit `lib/core/constants/app_constants.dart`:

```dart
class AppConstants {
  // Update with your API URL
  static const String baseUrl = 'https://your-api-url.com/v1';
  
  // Update other configurations as needed
}
```

### 2. Database Configuration

The database is automatically initialized. To customize:

Edit `lib/core/services/database_service.dart`:

```dart
static const String databaseName = 'hrms_database.db';
static const int databaseVersion = 1;
```

### 3. Encryption Keys

**IMPORTANT:** Change the default encryption key before production!

Edit `lib/core/utils/encryption_helper.dart`:

```dart
// Generate a secure 32-character key
static final _key = encrypt.Key.fromUtf8('your-32-character-key-here!!!');
```

### 4. Environment Variables (Optional)

Create `.env` file in the root directory:

```env
API_BASE_URL=https://your-api-url.com/v1
DATABASE_NAME=hrms_database.db
ENCRYPTION_KEY=your-encryption-key
```

## Running the Application

### Development Mode

```bash
# Run on Chrome (Web)
flutter run -d chrome

# Run on Android emulator
flutter run -d android

# Run on iOS simulator (macOS only)
flutter run -d ios

# Run on Windows
flutter run -d windows

# List all available devices
flutter devices
```

### Hot Reload

While the app is running:
- Press `r` to hot reload
- Press `R` to hot restart
- Press `q` to quit

### Debug Mode

```bash
# Run with verbose logging
flutter run -v

# Run with specific flavor (if configured)
flutter run --flavor development
```

## Building for Production

### Android

```bash
# Build APK
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release

# Output location:
# build/app/outputs/flutter-apk/app-release.apk
# build/app/outputs/bundle/release/app-release.aab
```

### iOS

```bash
# Build for iOS
flutter build ios --release

# Build IPA (requires Xcode)
flutter build ipa --release

# Output location:
# build/ios/iphoneos/Runner.app
```

### Web

```bash
# Build for web
flutter build web --release

# Output location:
# build/web/
```

### Desktop

```bash
# Windows
flutter build windows --release

# macOS
flutter build macos --release

# Linux
flutter build linux --release
```

## Troubleshooting

### Common Issues

#### 1. "Waiting for another flutter command to release the startup lock"

```bash
# Delete the lock file
rm -rf $FLUTTER_ROOT/bin/cache/lockfile  # macOS/Linux
del %FLUTTER_ROOT%\bin\cache\lockfile    # Windows
```

#### 2. "Gradle build failed"

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

#### 3. "CocoaPods not installed" (iOS)

```bash
sudo gem install cocoapods
pod setup
```

#### 4. Code generation issues

```bash
# Clean generated files
flutter clean
rm -rf .dart_tool/

# Regenerate
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

#### 5. "Version solving failed"

```bash
# Update dependencies
flutter pub upgrade

# Or force upgrade
flutter pub upgrade --major-versions
```

### Performance Issues

```bash
# Clear Flutter cache
flutter clean

# Clear pub cache
flutter pub cache repair

# Rebuild
flutter pub get
flutter run
```

### Platform-Specific Issues

**Android:**
- Ensure Android SDK is properly installed
- Check `android/local.properties` for SDK path
- Update Gradle if needed

**iOS:**
- Run `pod install` in `ios/` directory
- Clean Xcode build: `Product → Clean Build Folder`
- Update CocoaPods: `pod repo update`

**Web:**
- Clear browser cache
- Try incognito mode
- Check CORS settings if using API

## Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Flutter Cookbook](https://flutter.dev/docs/cookbook)
- [Project Architecture](../ARCHITECTURE.md)
- [Database Schema](DATABASE_SCHEMA.md)

## Getting Help

If you encounter issues:

1. Check the [Troubleshooting](#troubleshooting) section
2. Search existing issues on GitHub
3. Run `flutter doctor -v` and share the output
4. Contact the development team

## Next Steps

After successful setup:

1. Review the [Architecture Documentation](../ARCHITECTURE.md)
2. Explore the codebase structure
3. Run the tests: `flutter test`
4. Start developing features!

---

**Happy Coding! 🚀**

