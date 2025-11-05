# HR Management System - Architecture Documentation

## Overview
This is a comprehensive Human Resources Management System (HRMS) built with Flutter and Dart, following Clean Architecture principles and best practices for scalability, maintainability, and testability.

## Architecture Pattern

### Clean Architecture Layers

```
lib/
├── core/                          # Core functionality shared across features
│   ├── constants/                 # App-wide constants
│   ├── di/                        # Dependency injection setup
│   ├── errors/                    # Error handling (failures & exceptions)
│   ├── network/                   # Network layer (API client, network info)
│   ├── utils/                     # Utility functions and helpers
│   ├── theme/                     # App theming
│   ├── routes/                    # Navigation and routing
│   ├── services/                  # Core services (database, auth, etc.)
│   └── providers/                 # Global state providers
│
├── features/                      # Feature modules
│   ├── [feature_name]/
│   │   ├── data/                  # Data layer
│   │   │   ├── models/            # Data models (JSON serialization)
│   │   │   ├── datasources/       # Data sources (local & remote)
│   │   │   └── repositories/      # Repository implementations
│   │   │
│   │   ├── domain/                # Domain layer (business logic)
│   │   │   ├── entities/          # Business entities
│   │   │   ├── repositories/      # Repository interfaces
│   │   │   └── usecases/          # Use cases (business operations)
│   │   │
│   │   └── presentation/          # Presentation layer (UI)
│   │       ├── screens/           # Screen widgets
│   │       ├── widgets/           # Reusable widgets
│   │       ├── bloc/              # BLoC state management
│   │       └── providers/         # Feature-specific providers
│   │
└── main.dart                      # Application entry point
```

## Core Modules

### 1. Employee Data Management
**Location:** `lib/features/employees/`

**Entities:**
- `Employee` - Complete employee information
- `Department` - Department/division structure
- `Position` - Job positions and titles

**Features:**
- CRUD operations for employees
- Department and position management
- Employee search and filtering
- Profile image management
- Employee categorization

### 2. Attendance and Time Tracking
**Location:** `lib/features/attendance/`

**Entities:**
- `Attendance` - Daily attendance records
- `AttendanceRule` - Configurable attendance rules
- `Holiday` - Official holidays and rest days

**Features:**
- Check-in/check-out tracking
- Biometric integration support
- Customizable attendance rules per employee/department
- Late arrival and early departure tracking
- Overtime calculation
- Holiday management
- Real-time attendance monitoring

### 3. Leave Management
**Location:** `lib/features/leaves/`

**Entities:**
- `LeaveType` - Types of leaves (annual, sick, emergency, etc.)
- `LeaveRequest` - Leave applications
- `LeaveBalance` - Employee leave balances

**Features:**
- Multiple leave types support
- Leave request workflow
- Approval/rejection system
- Leave balance tracking
- Automatic accrual calculations
- Integration with payroll

### 4. Payroll System
**Location:** `lib/features/payroll/`

**Entities:**
- `Payroll` - Monthly payroll records
- `SalaryComponent` - Allowances, deductions, bonuses

**Features:**
- Automated salary calculation
- Attendance-based calculations
- Leave deductions
- Bonus and penalty management
- Tax calculations
- Payslip generation
- Multiple payment schedules

### 5. Performance Evaluations
**Location:** `lib/features/evaluations/`

**Entities:**
- `Evaluation` - Performance evaluation records

**Features:**
- Periodic evaluations (monthly, quarterly, annual)
- Multi-criteria scoring system
- Performance history tracking
- Goal setting and tracking
- Approval workflow

### 6. Contract Management
**Location:** `lib/features/contracts/`

**Entities:**
- `Contract` - Employment contracts

**Features:**
- Contract creation and management
- Multiple contract types
- Expiration alerts
- Contract renewal workflow
- Document generation

### 7. Document Management
**Location:** `lib/features/documents/`

**Entities:**
- `Document` - Employee documents

**Features:**
- Electronic document archiving
- Multi-format support (PDF, images, Word, etc.)
- Document categorization
- Version control
- Document verification
- Upload/download capabilities

## Technical Stack

### State Management
- **Provider** - Simple state management
- **BLoC** - Complex state management with business logic
- **Riverpod** - Modern reactive state management

### Database
- **SQLite (sqflite)** - Local database
- Support for SQL Server, PostgreSQL, MySQL via API

### Networking
- **Dio** - HTTP client for API calls
- **Connectivity Plus** - Network status monitoring

### Security
- **Encryption** - Data encryption using AES
- **Hashing** - Password hashing with SHA-256
- **Local Auth** - Biometric authentication

### File Handling
- **File Picker** - File selection
- **Path Provider** - File system paths
- **Image Picker** - Image selection

### Reports & Export
- **PDF** - PDF generation
- **Excel** - Excel file generation
- **CSV** - CSV export

### Localization
- **Easy Localization** - Multi-language support (Arabic RTL, English LTR)

### UI Components
- **Google Fonts** - Custom fonts
- **FL Chart** - Charts and graphs
- **Syncfusion Charts** - Advanced charts
- **Shimmer** - Loading animations

## Design Patterns

### 1. Repository Pattern
Abstracts data sources and provides a clean API for data access.

```dart
abstract class EmployeeRepository {
  Future<Either<Failure, List<Employee>>> getEmployees();
  Future<Either<Failure, Employee>> getEmployeeById(String id);
  Future<Either<Failure, void>> createEmployee(Employee employee);
  Future<Either<Failure, void>> updateEmployee(Employee employee);
  Future<Either<Failure, void>> deleteEmployee(String id);
}
```

### 2. Use Case Pattern
Encapsulates business logic in single-responsibility classes.

```dart
class GetEmployees {
  final EmployeeRepository repository;
  
  GetEmployees(this.repository);
  
  Future<Either<Failure, List<Employee>>> call() {
    return repository.getEmployees();
  }
}
```

### 3. Dependency Injection
Using GetIt and Injectable for dependency management.

```dart
@injectable
class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDataSource remoteDataSource;
  final EmployeeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  
  EmployeeRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo,
  );
}
```

## Error Handling

### Failures (Domain Layer)
- `ServerFailure` - Server-side errors
- `CacheFailure` - Local storage errors
- `NetworkFailure` - Network connectivity errors
- `ValidationFailure` - Input validation errors
- `AuthenticationFailure` - Authentication errors
- `AuthorizationFailure` - Permission errors

### Exceptions (Data Layer)
- `ServerException`
- `CacheException`
- `NetworkException`
- `ValidationException`
- `AuthenticationException`

## Security Features

### 1. Role-Based Access Control (RBAC)
- Predefined roles: Super Admin, Admin, HR Manager, HR Officer, Department Manager, Employee
- Granular permissions system
- Permission checking utilities

### 2. Data Encryption
- AES encryption for sensitive data
- SHA-256 password hashing
- Secure token storage

### 3. Authentication
- JWT token-based authentication
- Biometric authentication support
- Session management

## Offline-First Capability

### Data Synchronization
- Local SQLite database for offline storage
- Automatic sync when online
- Conflict resolution strategies
- Sync status tracking

### Offline Operations
- View cached data
- Create/update records offline
- Queue operations for sync
- Sync indicators in UI

## Multi-Language Support

### Supported Languages
- Arabic (RTL)
- English (LTR)

### Implementation
- Easy Localization package
- Translation files in `assets/translations/`
- Dynamic language switching
- RTL/LTR layout support

## Performance Optimization

### 1. Lazy Loading
- Paginated data loading
- Infinite scroll support

### 2. Caching
- Image caching with cached_network_image
- Data caching with expiry

### 3. Efficient Rendering
- ListView.builder for large lists
- Const constructors where possible
- Widget optimization

## Testing Strategy

### Unit Tests
- Use cases
- Repositories
- Utilities

### Widget Tests
- Individual widgets
- Screen layouts

### Integration Tests
- End-to-end workflows
- API integration

## Future Enhancements

1. **Shift Management** - Work shift scheduling
2. **Vehicle Tracking** - Company vehicle management
3. **Insurance Management** - Social and health insurance
4. **Advanced Analytics** - AI-powered insights
5. **Mobile App** - Native mobile experience
6. **Real-time Notifications** - Push notifications
7. **Biometric Device Integration** - ZK device integration
8. **Advanced Reporting** - Custom report builder

## Development Guidelines

### Code Style
- Follow Dart style guide
- Use meaningful variable names
- Add comments for complex logic
- Keep functions small and focused

### Git Workflow
- Feature branches
- Pull request reviews
- Semantic commit messages

### Documentation
- Document public APIs
- Update architecture docs
- Maintain changelog

## Getting Started

### Prerequisites
- Flutter SDK >= 3.10.0
- Dart SDK >= 3.0.0

### Installation
```bash
# Install dependencies
flutter pub get

# Generate code (for injectable, freezed, json_serializable)
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Configuration
1. Update API base URL in `lib/core/constants/app_constants.dart`
2. Configure database settings
3. Set up encryption keys
4. Configure localization

## License
Proprietary - All rights reserved

## Contact
For questions or support, contact the development team.

