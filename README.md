# HR Management System (HRMS)

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.10+-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)
![License](https://img.shields.io/badge/License-Proprietary-red.svg)

**A comprehensive Human Resources Management System built with Flutter**

[Features](#features) • [Architecture](#architecture) • [Getting Started](#getting-started) • [Documentation](#documentation)

</div>

---

## 📋 Overview

This is a full-featured, cross-platform Human Resources Management System (HRMS) designed to streamline HR operations for organizations of all sizes. Built with Flutter and Dart, it provides a modern, intuitive interface that works seamlessly across Web, Android, iOS, and Desktop platforms.

## ✨ Features

### 🧑‍💼 Employee Data Management
- Complete employee registry with personal and professional information
- CRUD operations for employee records
- Department and position management
- Advanced search and filtering
- Employee categorization and reporting

### ⏰ Attendance & Time Tracking
- Real-time attendance monitoring
- Biometric device integration (ZK devices)
- Customizable attendance rules per employee/department
- Flexible overtime calculation system
- Work days, rest days, and holiday configuration
- Late arrival and early departure tracking

### 🏖️ Leave Management
- Multiple leave types (annual, sick, emergency, unpaid, etc.)
- Leave request and approval workflow
- Leave balance tracking and history
- Automatic leave accrual calculations
- Integration with payroll system

### 💰 Payroll System
- Automated salary calculation
- Attendance-based payroll processing
- Leave deductions and bonuses
- Tax and insurance calculations
- Detailed payslip generation
- Multiple payment schedules support

### 📊 Performance Evaluations
- Periodic employee performance reviews
- Multi-criteria evaluation system
- Performance history tracking
- Goal setting and monitoring
- Approval workflow

### 📄 Contract Management
- Employment contract creation and management
- Multiple contract types support
- Automated expiration alerts
- Contract renewal workflow
- Document generation and printing

### 📁 Document Management
- Electronic document archiving
- Multi-format support (PDF, images, Word, Excel)
- Document categorization and version control
- Upload/download capabilities
- Document verification system

### 📈 Reports & Dashboards
- Professional admin dashboard with live KPIs
- Comprehensive reports for all modules
- Export to PDF, Excel, and CSV
- Customizable filters and date ranges
- Visual charts and graphs

### 🔐 Security & Access Control
- Role-based access control (RBAC)
- Multiple user roles and permissions
- Secure authentication and authorization
- Data encryption and secure storage
- Audit logging

### 🌍 Multi-Language Support
- Arabic (RTL) and English (LTR)
- Easy language switching
- Localized date and number formats

### 📱 Cross-Platform
- Web application
- Android mobile app
- iOS mobile app
- Windows/macOS/Linux desktop apps

### 🔄 Offline-First
- Local data storage with SQLite
- Automatic synchronization when online
- Offline data access and operations
- Conflict resolution

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
├── Core Layer (Shared functionality)
├── Data Layer (Data sources, models, repositories)
├── Domain Layer (Entities, use cases, repository interfaces)
└── Presentation Layer (UI, state management, widgets)
```

### Key Design Patterns
- **Repository Pattern** - Data abstraction
- **Use Case Pattern** - Business logic encapsulation
- **Dependency Injection** - Using GetIt and Injectable
- **BLoC Pattern** - State management
- **Provider Pattern** - Simple state management

For detailed architecture documentation, see [ARCHITECTURE.md](ARCHITECTURE.md).

## 🚀 Getting Started

### Prerequisites

- Flutter SDK >= 3.10.0
- Dart SDK >= 3.0.0
- Android Studio / VS Code with Flutter extensions
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/hr_management_system.git
   cd hr_management_system
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the application**
   ```bash
   # For web
   flutter run -d chrome
   
   # For Android
   flutter run -d android
   
   # For iOS
   flutter run -d ios
   
   # For desktop
   flutter run -d windows  # or macos, linux
   ```

### Configuration

1. **API Configuration**
   - Update the base URL in `lib/core/constants/app_constants.dart`
   ```dart
   static const String baseUrl = 'https://your-api-url.com/v1';
   ```

2. **Database Configuration**
   - Database settings are in `lib/core/services/database_service.dart`
   - Default database name: `hrms_database.db`

3. **Encryption Keys**
   - Update encryption keys in `lib/core/utils/encryption_helper.dart`
   - **Important:** Use secure, randomly generated keys in production

4. **Localization**
   - Translation files are in `assets/translations/`
   - Add new languages by creating new JSON files

## 📚 Documentation

- [Architecture Documentation](ARCHITECTURE.md) - Detailed architecture overview
- [API Documentation](docs/API.md) - API endpoints and usage (coming soon)
- [User Guide](docs/USER_GUIDE.md) - End-user documentation (coming soon)
- [Developer Guide](docs/DEVELOPER_GUIDE.md) - Development guidelines (coming soon)

## 🛠️ Tech Stack

### Core
- **Flutter** - UI framework
- **Dart** - Programming language

### State Management
- **Provider** - Simple state management
- **BLoC** - Business logic component
- **Riverpod** - Reactive state management

### Database & Storage
- **SQLite (sqflite)** - Local database
- **SharedPreferences** - Key-value storage
- **Path Provider** - File system access

### Networking
- **Dio** - HTTP client
- **Connectivity Plus** - Network monitoring

### Security
- **Crypto** - Encryption and hashing
- **Encrypt** - AES encryption
- **Local Auth** - Biometric authentication

### UI Components
- **Google Fonts** - Custom fonts
- **FL Chart** - Charts and graphs
- **Syncfusion Charts** - Advanced charts
- **Shimmer** - Loading animations

### File Handling
- **File Picker** - File selection
- **Image Picker** - Image selection
- **PDF** - PDF generation
- **Excel** - Excel file generation

### Localization
- **Easy Localization** - Multi-language support

### Dependency Injection
- **GetIt** - Service locator
- **Injectable** - Code generation for DI

### Utilities
- **Dartz** - Functional programming
- **Equatable** - Value equality
- **UUID** - Unique ID generation
- **Logger** - Logging

## 📦 Project Structure

```
lib/
├── core/                       # Core functionality
│   ├── constants/              # App constants
│   ├── di/                     # Dependency injection
│   ├── errors/                 # Error handling
│   ├── network/                # Network layer
│   ├── utils/                  # Utilities
│   ├── theme/                  # App theming
│   ├── routes/                 # Navigation
│   └── services/               # Core services
│
├── features/                   # Feature modules
│   ├── employees/              # Employee management
│   ├── attendance/             # Attendance tracking
│   ├── leaves/                 # Leave management
│   ├── payroll/                # Payroll system
│   ├── contracts/              # Contract management
│   ├── documents/              # Document management
│   ├── evaluations/            # Performance evaluations
│   └── auth/                   # Authentication
│
└── main.dart                   # App entry point
```

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter test integration_test
```

## 🔨 Build

```bash
# Build for Android
flutter build apk --release

# Build for iOS
flutter build ios --release

# Build for Web
flutter build web --release

# Build for Windows
flutter build windows --release
```

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is proprietary software. All rights reserved.

## 👥 Authors

- **Your Name** - *Initial work*

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- All open-source package contributors
- The Dart community

## 📞 Support

For support, email support@yourcompany.com or open an issue in the repository.

---

<div align="center">
Made with ❤️ using Flutter
</div>

