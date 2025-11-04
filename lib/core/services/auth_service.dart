import 'dart:convert';
import 'package:crypto/crypto.dart';

class AuthService extends ChangeNotifier {
  String? _currentUser;
  String? _userRole;
  bool _isAuthenticated = false;
  
  // بيانات المستخدم الحالي
  String? get currentUser => _currentUser;
  String? get userRole => _userRole;
  bool get isAuthenticated => _isAuthenticated;
  
  // الصلاحيات والأدوار
  static const String roleAdmin = 'admin';
  static const String roleHR = 'hr_manager';
  static const String roleManager = 'department_manager';
  static const String roleEmployee = 'employee';
  
  // تسجيل الدخول
  Future<bool> login(String username, String password) async {
    try {
      // تشفير كلمة المرور
      final hashedPassword = _hashPassword(password);
      
      // هنا يتم التحقق من بيانات تسجيل الدخول مع قاعدة البيانات
      // للآن سنستخدم بيانات تجريبية
      if (username == 'admin' && password == 'admin123') {
        _currentUser = username;
        _userRole = roleAdmin;
        _isAuthenticated = true;
        notifyListeners();
        return true;
      }
      
      if (username == 'hr' && password == 'hr123') {
        _currentUser = username;
        _userRole = roleHR;
        _isAuthenticated = true;
        notifyListeners();
        return true;
      }
      
      if (username == 'manager' && password == 'manager123') {
        _currentUser = username;
        _userRole = roleManager;
        _isAuthenticated = true;
        notifyListeners();
        return true;
      }
      
      if (username == 'employee' && password == 'employee123') {
        _currentUser = username;
        _userRole = roleEmployee;
        _isAuthenticated = true;
        notifyListeners();
        return true;
      }
      
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }
  
  // تسجيل الخروج
  Future<void> logout() async {
    _currentUser = null;
    _userRole = null;
    _isAuthenticated = false;
    notifyListeners();
  }
  
  // التحقق من الصلاحيات
  bool hasPermission(String permission) {
    if (!_isAuthenticated) return false;
    
    // صلاحيات المدير
    if (_userRole == roleAdmin) {
      return true; // المدير لديه جميع الصلاحيات
    }
    
    // صلاحيات مدير الموارد البشرية
    if (_userRole == roleHR) {
      return [
        'view_employees',
        'edit_employees',
        'view_attendance',
        'manage_attendance',
        'view_leaves',
        'approve_leaves',
        'view_payroll',
        'manage_payroll',
        'view_reports',
        'manage_documents',
      ].contains(permission);
    }
    
    // صلاحيات مدير القسم
    if (_userRole == roleManager) {
      return [
        'view_employees',
        'view_attendance',
        'view_leaves',
        'approve_leaves_department',
        'view_reports_department',
      ].contains(permission);
    }
    
    // صلاحيات الموظف
    if (_userRole == roleEmployee) {
      return [
        'view_profile',
        'view_attendance',
        'request_leaves',
        'view_documents',
      ].contains(permission);
    }
    
    return false;
  }
  
  // التحقق من عدة صلاحيات
  bool hasAnyPermission(List<String> permissions) {
    for (final permission in permissions) {
      if (hasPermission(permission)) {
        return true;
      }
    }
    return false;
  }
  
  // التحقق من جميع الصلاحيات
  bool hasAllPermissions(List<String> permissions) {
    for (final permission in permissions) {
      if (!hasPermission(permission)) {
        return false;
      }
    }
    return true;
  }
  
  // تغيير كلمة المرور
  Future<bool> changePassword(String oldPassword, String newPassword) async {
    try {
      // هنا يتم تغيير كلمة المرور في قاعدة البيانات
      // للآن سنقوم بمحاكاة العملية
      return true;
    } catch (e) {
      print('Change password error: $e');
      return false;
    }
  }
  
  // استعادة كلمة المرور
  Future<bool> forgotPassword(String email) async {
    try {
      // هنا يتم إرسال رابط استعادة كلمة المرور
      return true;
    } catch (e) {
      print('Forgot password error: $e');
      return false;
    }
  }
  
  // تشفير كلمة المرور
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  
  // التحقق من صلاحية الجلسة
  Future<bool> validateSession() async {
    // هنا يتم التحقق من صلاحية الجلسة مع الخادم
    return _isAuthenticated;
  }
  
  // تحديث بيانات المستخدم
  Future<void> updateUserData(Map<String, dynamic> userData) async {
    // هنا يتم تحديث بيانات المستخدم
    notifyListeners();
  }
  
  // الحصول على معلومات المستخدم
  Map<String, dynamic> getUserInfo() {
    return {
      'username': _currentUser,
      'role': _userRole,
      'isAuthenticated': _isAuthenticated,
    };
  }
}