# Getting Started with HR Management System

Welcome to the HR Management System! This guide will help you understand the project structure and get started with development.

## 📚 Quick Links

- [README.md](README.md) - Project overview and features
- [ARCHITECTURE.md](ARCHITECTURE.md) - Detailed architecture documentation
- [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) - Implementation status and next steps
- [docs/SETUP_GUIDE.md](docs/SETUP_GUIDE.md) - Complete setup instructions
- [docs/DATABASE_SCHEMA.md](docs/DATABASE_SCHEMA.md) - Database schema documentation

## 🎯 What Has Been Built

### ✅ Phase 1: Core Architecture & Foundation (COMPLETE)

The foundational architecture is fully implemented with:

1. **Core Constants** - All application-wide constants and configurations
2. **Error Handling** - Comprehensive failure and exception system
3. **Utilities** - Validators, date utils, encryption, file handling, permissions
4. **Network Layer** - API client with Dio, network monitoring
5. **Dependency Injection** - GetIt and Injectable setup
6. **Domain Entities** - All business entities for 7 modules:
   - Employee Management (Employee, Department, Position)
   - Attendance Tracking (Attendance, AttendanceRule, Holiday)
   - Leave Management (LeaveType, LeaveRequest, LeaveBalance)
   - Payroll System (Payroll, SalaryComponent)
   - Contract Management (Contract)
   - Document Management (Document)
   - Performance Evaluations (Evaluation)

7. **Repository Interfaces** - Clean architecture repository contracts
8. **Sample Use Cases** - Example use case implementations
9. **Documentation** - Comprehensive docs for architecture, setup, and database

## 🚀 Quick Start

### 1. Prerequisites Check

```bash
# Verify Flutter installation
flutter doctor

# Should show Flutter 3.10+ and Dart 3.0+
```

### 2. Install Dependencies

```bash
# Get all packages
flutter pub get

# Generate code (IMPORTANT!)
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Configure the Application

**Update API URL** in `lib/core/constants/app_constants.dart`:
```dart
static const String baseUrl = 'https://your-api-url.com/v1';
```

**Update Encryption Key** in `lib/core/utils/encryption_helper.dart`:
```dart
static final _key = encrypt.Key.fromUtf8('your-32-character-key-here!!!');
```

### 4. Create Translation Files

Create `assets/translations/ar.json` and `assets/translations/en.json` with your translations.

### 5. Run the Application

```bash
# For web
flutter run -d chrome

# For Android
flutter run -d android

# For iOS (macOS only)
flutter run -d ios
```

## 📁 Project Structure Overview

```
lib/
├── core/                          # Shared functionality
│   ├── constants/                 # ✅ App constants
│   ├── di/                        # ✅ Dependency injection
│   ├── errors/                    # ✅ Error handling
│   ├── network/                   # ✅ Network layer
│   ├── utils/                     # ✅ Utilities
│   ├── theme/                     # ⏳ App theming
│   ├── routes/                    # ⏳ Navigation
│   ├── services/                  # ⏳ Core services
│   └── providers/                 # ⏳ Global providers
│
├── features/                      # Feature modules
│   ├── employees/
│   │   ├── domain/                # ✅ Entities, repositories, use cases
│   │   ├── data/                  # ⏳ Models, data sources, repo impl
│   │   └── presentation/          # ⏳ UI, widgets, state management
│   │
│   ├── attendance/                # ✅ Domain layer complete
│   ├── leaves/                    # ✅ Domain layer complete
│   ├── payroll/                   # ✅ Domain layer complete
│   ├── contracts/                 # ✅ Domain layer complete
│   ├── documents/                 # ✅ Domain layer complete
│   ├── evaluations/               # ✅ Domain layer complete
│   ├── auth/                      # ⏳ To be implemented
│   └── main/                      # ⏳ To be implemented
│
└── main.dart                      # ✅ App entry point
```

**Legend:**
- ✅ Complete
- ⏳ To be implemented

## 🔨 Next Development Steps

### Immediate Next Steps (Phase 2: Data Layer)

1. **Create Data Models** for each entity with JSON serialization
   ```dart
   // Example: lib/features/employees/data/models/employee_model.dart
   @JsonSerializable()
   class EmployeeModel extends Employee {
     // JSON serialization code
   }
   ```

2. **Implement Local Data Sources** (SQLite)
   ```dart
   // Example: lib/features/employees/data/datasources/employee_local_datasource.dart
   abstract class EmployeeLocalDataSource {
     Future<List<EmployeeModel>> getEmployees();
     Future<void> cacheEmployees(List<EmployeeModel> employees);
   }
   ```

3. **Implement Remote Data Sources** (API)
   ```dart
   // Example: lib/features/employees/data/datasources/employee_remote_datasource.dart
   abstract class EmployeeRemoteDataSource {
     Future<List<EmployeeModel>> getEmployees();
     Future<void> createEmployee(EmployeeModel employee);
   }
   ```

4. **Implement Repository Implementations**
   ```dart
   // Example: lib/features/employees/data/repositories/employee_repository_impl.dart
   class EmployeeRepositoryImpl implements EmployeeRepository {
     // Implementation using data sources
   }
   ```

### Recommended Development Order

1. **Employee Module** (Start here - it's the foundation)
   - Data models
   - Data sources
   - Repository implementation
   - Complete use cases
   - UI screens

2. **Authentication Module**
   - Login/logout functionality
   - Token management
   - User session

3. **Attendance Module**
   - Check-in/check-out
   - Attendance rules
   - Reports

4. **Leave Management Module**
   - Leave requests
   - Approval workflow
   - Balance tracking

5. **Payroll Module**
   - Salary calculation
   - Payslip generation

6. **Other Modules**
   - Contracts
   - Documents
   - Evaluations

## 💡 Development Tips

### 1. Follow Clean Architecture

Always maintain the layer separation:
- **Domain Layer**: Business logic, entities, repository interfaces
- **Data Layer**: Data sources, models, repository implementations
- **Presentation Layer**: UI, widgets, state management

### 2. Use Code Generation

After creating models with `@JsonSerializable()` or `@injectable`:
```bash
flutter pub run build_runner watch
```

### 3. State Management

- Use **BLoC** for complex business logic
- Use **Provider** for simple state
- Use **Riverpod** for reactive state

### 4. Error Handling

Always use the `Either` type from Dartz:
```dart
ResultFuture<Employee> getEmployee(String id) async {
  try {
    final employee = await dataSource.getEmployee(id);
    return Right(employee);
  } catch (e) {
    return Left(ServerFailure(message: e.toString()));
  }
}
```

### 5. Testing

Write tests as you develop:
```bash
# Run tests
flutter test

# Run with coverage
flutter test --coverage
```

## 📖 Learning Resources

### Understanding the Architecture

1. **Read ARCHITECTURE.md** - Understand the overall architecture
2. **Review Domain Entities** - See how business entities are structured
3. **Check Repository Interfaces** - Understand the contracts
4. **Look at Sample Use Cases** - See how business logic is encapsulated

### Clean Architecture Resources

- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Clean Architecture](https://resocoder.com/flutter-clean-architecture-tdd/)
- [BLoC Pattern](https://bloclibrary.dev/)

### Flutter Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Cookbook](https://flutter.dev/docs/cookbook)

## 🐛 Common Issues

### Issue: Build runner fails
```bash
# Solution: Clean and rebuild
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue: Dependency conflicts
```bash
# Solution: Update dependencies
flutter pub upgrade
```

### Issue: Import errors
```bash
# Solution: Ensure code generation is complete
flutter pub run build_runner build --delete-conflicting-outputs
```

## 📝 Code Style Guidelines

1. **Use meaningful names** - Variables, functions, classes should be self-documenting
2. **Keep functions small** - Single responsibility principle
3. **Add comments** - Explain complex logic
4. **Use const constructors** - For better performance
5. **Follow Dart style guide** - Use `dart format`

## 🔐 Security Reminders

1. **Never commit sensitive data** - API keys, passwords, encryption keys
2. **Use environment variables** - For configuration
3. **Update encryption keys** - Before production deployment
4. **Implement proper authentication** - JWT tokens, secure storage
5. **Validate all inputs** - Use the validators in `core/utils/validators.dart`

## 🎨 UI Development

When you start building UI:

1. **Use the theme system** - Defined in `core/theme/`
2. **Create reusable widgets** - In feature's `presentation/widgets/`
3. **Follow Material Design** - Or Cupertino for iOS
4. **Support both RTL and LTR** - For Arabic and English
5. **Make it responsive** - Support all screen sizes

## 📊 Database Development

When implementing database operations:

1. **Follow the schema** - See `docs/DATABASE_SCHEMA.md`
2. **Use transactions** - For data integrity
3. **Handle migrations** - Version your database schema
4. **Index properly** - For query performance
5. **Test thoroughly** - Database operations are critical

## 🚀 Deployment Checklist

Before deploying to production:

- [ ] Update API base URL
- [ ] Change encryption keys
- [ ] Remove debug code
- [ ] Test on all platforms
- [ ] Run all tests
- [ ] Build release versions
- [ ] Test release builds
- [ ] Update documentation
- [ ] Create changelog

## 🤝 Getting Help

If you need help:

1. **Check the documentation** - Most answers are in the docs
2. **Review existing code** - See how similar features are implemented
3. **Search issues** - Someone might have faced the same problem
4. **Ask the team** - Don't hesitate to reach out

## 🎯 Success Criteria

You'll know you're on the right track when:

- ✅ Code follows Clean Architecture principles
- ✅ All layers are properly separated
- ✅ Error handling is comprehensive
- ✅ Tests are passing
- ✅ Code is well-documented
- ✅ UI is responsive and intuitive
- ✅ Performance is optimized

## 📅 Development Roadmap

**Week 1-2**: Data Layer Implementation
**Week 3-4**: Complete Domain Layer (Use Cases)
**Week 5-8**: Presentation Layer (UI)
**Week 9-10**: Advanced Features
**Week 11-12**: Testing & Polish

---

**Happy Coding! 🚀**

For detailed information, refer to the comprehensive documentation in the `docs/` folder.

