import '../constants/app_constants.dart';

/// Permission checking utilities for RBAC
class PermissionHelper {
  /// Check if user has a specific permission
  static bool hasPermission(List<String> userPermissions, String permission) {
    return userPermissions.contains(permission);
  }
  
  /// Check if user has any of the specified permissions
  static bool hasAnyPermission(List<String> userPermissions, List<String> permissions) {
    return permissions.any((permission) => userPermissions.contains(permission));
  }
  
  /// Check if user has all of the specified permissions
  static bool hasAllPermissions(List<String> userPermissions, List<String> permissions) {
    return permissions.every((permission) => userPermissions.contains(permission));
  }
  
  /// Check if user has a specific role
  static bool hasRole(List<String> userRoles, String role) {
    return userRoles.contains(role);
  }
  
  /// Check if user has any of the specified roles
  static bool hasAnyRole(List<String> userRoles, List<String> roles) {
    return roles.any((role) => userRoles.contains(role));
  }
  
  /// Check if user is super admin
  static bool isSuperAdmin(List<String> userRoles) {
    return userRoles.contains(RoleNames.superAdmin);
  }
  
  /// Check if user is admin
  static bool isAdmin(List<String> userRoles) {
    return userRoles.contains(RoleNames.admin) || isSuperAdmin(userRoles);
  }
  
  /// Check if user is HR manager
  static bool isHRManager(List<String> userRoles) {
    return userRoles.contains(RoleNames.hrManager) || isAdmin(userRoles);
  }
  
  /// Check if user can view employees
  static bool canViewEmployees(List<String> userPermissions) {
    return hasPermission(userPermissions, PermissionTypes.viewEmployees);
  }
  
  /// Check if user can create employee
  static bool canCreateEmployee(List<String> userPermissions) {
    return hasPermission(userPermissions, PermissionTypes.createEmployee);
  }
  
  /// Check if user can edit employee
  static bool canEditEmployee(List<String> userPermissions) {
    return hasPermission(userPermissions, PermissionTypes.editEmployee);
  }
  
  /// Check if user can delete employee
  static bool canDeleteEmployee(List<String> userPermissions) {
    return hasPermission(userPermissions, PermissionTypes.deleteEmployee);
  }
  
  /// Check if user can manage attendance
  static bool canManageAttendance(List<String> userPermissions) {
    return hasPermission(userPermissions, PermissionTypes.manageAttendance);
  }
  
  /// Check if user can approve leave
  static bool canApproveLeave(List<String> userPermissions) {
    return hasPermission(userPermissions, PermissionTypes.approveLeave);
  }
  
  /// Check if user can manage payroll
  static bool canManagePayroll(List<String> userPermissions) {
    return hasPermission(userPermissions, PermissionTypes.managePayroll);
  }
  
  /// Check if user can view reports
  static bool canViewReports(List<String> userPermissions) {
    return hasPermission(userPermissions, PermissionTypes.viewReports);
  }
  
  /// Check if user can export reports
  static bool canExportReports(List<String> userPermissions) {
    return hasPermission(userPermissions, PermissionTypes.exportReports);
  }
  
  /// Check if user can manage settings
  static bool canManageSettings(List<String> userPermissions) {
    return hasPermission(userPermissions, PermissionTypes.manageSettings);
  }
  
  /// Get default permissions for a role
  static List<String> getDefaultPermissionsForRole(String role) {
    switch (role) {
      case RoleNames.superAdmin:
        return _getAllPermissions();
      
      case RoleNames.admin:
        return [
          PermissionTypes.viewEmployees,
          PermissionTypes.createEmployee,
          PermissionTypes.editEmployee,
          PermissionTypes.deleteEmployee,
          PermissionTypes.viewAttendance,
          PermissionTypes.manageAttendance,
          PermissionTypes.viewLeaves,
          PermissionTypes.approveLeave,
          PermissionTypes.rejectLeave,
          PermissionTypes.viewPayroll,
          PermissionTypes.managePayroll,
          PermissionTypes.viewReports,
          PermissionTypes.exportReports,
          PermissionTypes.manageUsers,
          PermissionTypes.manageRoles,
        ];
      
      case RoleNames.hrManager:
        return [
          PermissionTypes.viewEmployees,
          PermissionTypes.createEmployee,
          PermissionTypes.editEmployee,
          PermissionTypes.viewAttendance,
          PermissionTypes.manageAttendance,
          PermissionTypes.viewLeaves,
          PermissionTypes.approveLeave,
          PermissionTypes.rejectLeave,
          PermissionTypes.viewPayroll,
          PermissionTypes.managePayroll,
          PermissionTypes.viewReports,
          PermissionTypes.exportReports,
        ];
      
      case RoleNames.hrOfficer:
        return [
          PermissionTypes.viewEmployees,
          PermissionTypes.createEmployee,
          PermissionTypes.editEmployee,
          PermissionTypes.viewAttendance,
          PermissionTypes.viewLeaves,
          PermissionTypes.viewReports,
        ];
      
      case RoleNames.departmentManager:
        return [
          PermissionTypes.viewEmployees,
          PermissionTypes.viewAttendance,
          PermissionTypes.viewLeaves,
          PermissionTypes.approveLeave,
          PermissionTypes.rejectLeave,
          PermissionTypes.viewReports,
        ];
      
      case RoleNames.employee:
        return [
          PermissionTypes.viewOwnAttendance,
          PermissionTypes.requestLeave,
          PermissionTypes.viewOwnPayroll,
        ];
      
      default:
        return [];
    }
  }
  
  /// Get all available permissions
  static List<String> _getAllPermissions() {
    return [
      PermissionTypes.viewEmployees,
      PermissionTypes.createEmployee,
      PermissionTypes.editEmployee,
      PermissionTypes.deleteEmployee,
      PermissionTypes.viewAttendance,
      PermissionTypes.manageAttendance,
      PermissionTypes.viewOwnAttendance,
      PermissionTypes.viewLeaves,
      PermissionTypes.requestLeave,
      PermissionTypes.approveLeave,
      PermissionTypes.rejectLeave,
      PermissionTypes.viewPayroll,
      PermissionTypes.managePayroll,
      PermissionTypes.viewOwnPayroll,
      PermissionTypes.viewReports,
      PermissionTypes.exportReports,
      PermissionTypes.manageSettings,
      PermissionTypes.manageUsers,
      PermissionTypes.manageRoles,
      PermissionTypes.viewAuditLogs,
    ];
  }
}

