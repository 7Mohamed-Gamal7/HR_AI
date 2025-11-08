/// Application-wide constants
class AppConstants {
  // App Information
  static const String appName = 'HR Management System';
  static const String appNameAr = 'نظام إدارة الموارد البشرية';
  static const String appVersion = '1.0.0';

  // Database
  static const String databaseName = 'hrms_database.db';
  static const int databaseVersion = 1;

  // API Configuration
  static const String baseUrl = 'https://api.hrms.com/v1';
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'dd/MM/yyyy';
  static const String displayDateTimeFormat = 'dd/MM/yyyy hh:mm a';
  static const String timeFormat = 'HH:mm';
  static const String displayTimeFormat = 'hh:mm a';

  // File Upload
  static const int maxFileSize = 10 * 1024 * 1024; // 10 MB
  static const List<String> allowedImageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'gif',
  ];
  static const List<String> allowedDocumentExtensions = [
    'pdf',
    'doc',
    'docx',
    'xls',
    'xlsx',
  ];

  // Encryption
  static const String encryptionKey = 'your-32-character-encryption-key-here';

  // Session
  static const int sessionTimeout = 3600; // 1 hour in seconds
  static const int refreshTokenBeforeExpiry = 300; // 5 minutes

  // Attendance
  static const int defaultWorkHoursPerDay = 8;
  static const int defaultWorkDaysPerWeek = 5;
  static const int defaultLateMinutesAllowed = 15;
  static const int defaultEarlyDepartureMinutesAllowed = 15;

  // Leave
  static const int defaultAnnualLeaveDays = 21;
  static const int defaultSickLeaveDays = 14;
  static const int maxConsecutiveLeaveDays = 30;

  // Payroll
  static const String defaultCurrency = 'EGP';
  static const String defaultCurrencySymbol = 'ج.م';

  // Notifications
  static const int notificationReminderDays = 7; // Days before contract expiry

  // Cache
  static const int cacheExpiryDuration = 3600; // 1 hour in seconds

  // Biometric
  static const int biometricMaxRetries = 3;
  static const int biometricTimeout = 30; // seconds
}

/// Database table names
class TableNames {
  static const String users = 'users';
  static const String employees = 'employees';
  static const String departments = 'departments';
  static const String positions = 'positions';
  static const String attendance = 'attendance';
  static const String leaves = 'leaves';
  static const String leaveTypes = 'leave_types';
  static const String leaveRequests = 'leave_requests';
  static const String leaveBalances = 'leave_balances';
  static const String payroll = 'payroll';
  static const String salaryComponents = 'salary_components';
  static const String contracts = 'contracts';
  static const String evaluations = 'evaluations';
  static const String documents = 'documents';
  static const String shifts = 'shifts';
  static const String shiftAssignments = 'shift_assignments';
  static const String vehicles = 'vehicles';
  static const String vehicleAssignments = 'vehicle_assignments';
  static const String insurance = 'insurance';
  static const String employeeActions = 'employee_actions';
  static const String holidays = 'holidays';
  static const String attendanceRules = 'attendance_rules';
  static const String permissions = 'permissions';
  static const String roles = 'roles';
  static const String rolePermissions = 'role_permissions';
  static const String userRoles = 'user_roles';
  static const String settings = 'settings';
  static const String auditLogs = 'audit_logs';
  static const String notifications = 'notifications';
}

/// API endpoints
class ApiEndpoints {
  // Authentication
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String changePassword = '/auth/change-password';

  // Employees
  static const String employees = '/employees';
  static const String employeeById = '/employees/{id}';
  static const String employeesByDepartment = '/employees/department/{id}';
  static const String departments = '/departments';
  static const String positions = '/positions';

  // Attendance
  static const String attendance = '/attendance';
  static const String attendanceByEmployee = '/attendance/employee/{id}';
  static const String attendanceReport = '/attendance/report';
  static const String checkIn = '/attendance/check-in';
  static const String checkOut = '/attendance/check-out';
  static const String attendanceRules = '/attendance-rules';
  static const String holidays = '/holidays';

  // Leaves
  static const String leaves = '/leaves';
  static const String leaveRequest = '/leaves/request';
  static const String leaveApproval = '/leaves/approve/{id}';
  static const String leaveRejection = '/leaves/reject/{id}';

  // Payroll
  static const String payroll = '/payroll';
  static const String payrollGenerate = '/payroll/generate';
  static const String payslip = '/payroll/payslip/{id}';

  // Reports
  static const String reports = '/reports';
  static const String reportAttendance = '/reports/attendance';
  static const String reportPayroll = '/reports/payroll';
  static const String reportLeaves = '/reports/leaves';

  // Documents
  static const String documents = '/documents';
  static const String documentUpload = '/documents/upload';
  static const String documentDownload = '/documents/download/{id}';

  // Biometric
  static const String biometricDevices = '/biometric/devices';
  static const String biometricSync = '/biometric/sync';
}

/// Storage keys for SharedPreferences
class StorageKeys {
  static const String isLoggedIn = 'is_logged_in';
  static const String userId = 'user_id';
  static const String userName = 'user_name';
  static const String userEmail = 'user_email';
  static const String userRole = 'user_role';
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String tokenExpiry = 'token_expiry';
  static const String language = 'language';
  static const String theme = 'theme';
  static const String biometricEnabled = 'biometric_enabled';
  static const String lastSyncTime = 'last_sync_time';
  static const String offlineMode = 'offline_mode';
}

/// Permission types for RBAC
class PermissionTypes {
  // Employee permissions
  static const String viewEmployees = 'view_employees';
  static const String createEmployee = 'create_employee';
  static const String editEmployee = 'edit_employee';
  static const String deleteEmployee = 'delete_employee';

  // Attendance permissions
  static const String viewAttendance = 'view_attendance';
  static const String manageAttendance = 'manage_attendance';
  static const String viewOwnAttendance = 'view_own_attendance';

  // Leave permissions
  static const String viewLeaves = 'view_leaves';
  static const String requestLeave = 'request_leave';
  static const String approveLeave = 'approve_leave';
  static const String rejectLeave = 'reject_leave';

  // Payroll permissions
  static const String viewPayroll = 'view_payroll';
  static const String managePayroll = 'manage_payroll';
  static const String viewOwnPayroll = 'view_own_payroll';

  // Report permissions
  static const String viewReports = 'view_reports';
  static const String exportReports = 'export_reports';

  // System permissions
  static const String manageSettings = 'manage_settings';
  static const String manageUsers = 'manage_users';
  static const String manageRoles = 'manage_roles';
  static const String viewAuditLogs = 'view_audit_logs';
}

/// Default role names
class RoleNames {
  static const String superAdmin = 'Super Admin';
  static const String admin = 'Admin';
  static const String hrManager = 'HR Manager';
  static const String hrOfficer = 'HR Officer';
  static const String departmentManager = 'Department Manager';
  static const String employee = 'Employee';
}

/// Leave types
class LeaveTypeConstants {
  static const String annual = 'annual';
  static const String sick = 'sick';
  static const String emergency = 'emergency';
  static const String unpaid = 'unpaid';
  static const String maternity = 'maternity';
  static const String paternity = 'paternity';
  static const String study = 'study';
  static const String hajj = 'hajj';
}

/// Leave status
class LeaveStatus {
  static const String pending = 'pending';
  static const String approved = 'approved';
  static const String rejected = 'rejected';
  static const String cancelled = 'cancelled';
}

/// Attendance status
class AttendanceStatus {
  static const String present = 'present';
  static const String absent = 'absent';
  static const String late = 'late';
  static const String earlyDeparture = 'early_departure';
  static const String onLeave = 'on_leave';
  static const String holiday = 'holiday';
  static const String weekend = 'weekend';
}

/// Contract types
class ContractTypes {
  static const String permanent = 'permanent';
  static const String temporary = 'temporary';
  static const String partTime = 'part_time';
  static const String contract = 'contract';
  static const String internship = 'internship';
}

/// Employee action types
class EmployeeActionTypes {
  static const String promotion = 'promotion';
  static const String demotion = 'demotion';
  static const String bonus = 'bonus';
  static const String penalty = 'penalty';
  static const String allowance = 'allowance';
  static const String deduction = 'deduction';
  static const String warning = 'warning';
  static const String transfer = 'transfer';
}

/// Document categories
class DocumentCategories {
  static const String personal = 'personal';
  static const String educational = 'educational';
  static const String professional = 'professional';
  static const String medical = 'medical';
  static const String contract = 'contract';
  static const String certificate = 'certificate';
  static const String other = 'other';
}

/// Gender types
class GenderTypes {
  static const String male = 'male';
  static const String female = 'female';
}

/// Marital status
class MaritalStatus {
  static const String single = 'single';
  static const String married = 'married';
  static const String divorced = 'divorced';
  static const String widowed = 'widowed';
}
