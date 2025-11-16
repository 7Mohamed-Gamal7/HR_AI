import 'package:flutter/material.dart';
import 'package:hr_management_system/features/auth/screens/login_screen.dart';
import 'package:hr_management_system/features/main/screens/main_screen.dart';
import 'package:hr_management_system/features/employees/screens/employees_screen.dart';
import 'package:hr_management_system/features/attendance/screens/attendance_screen.dart';
import 'package:hr_management_system/features/leaves/screens/leaves_screen.dart';
import 'package:hr_management_system/features/payroll/screens/payroll_screen.dart';

class AppRoutes {
  // المسارات الأساسية
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String employees = '/employees';
  // يمكن إضافة تفاصيل الموظف لاحقاً
  static const String attendance = '/attendance';
  static const String leaves = '/leaves';
  static const String payroll = '/payroll';
  // مسارات لاحقة: التقييمات/الوثائق/التقارير/الإعدادات
  
  // المسارات الفرعية
  static const String attendanceRules = '/attendance/rules';
  static const String attendanceReports = '/attendance/reports';
  static const String leaveTypes = '/leaves/types';
  static const String leaveRequests = '/leaves/requests';
  static const String payrollSettings = '/payroll/settings';
  static const String salarySlips = '/payroll/salary-slips';
  static const String evaluationForms = '/evaluations/forms';
  static const String contracts = '/evaluations/contracts';
  static const String documentCategories = '/documents/categories';
  static const String documentUpload = '/documents/upload';
  static const String userProfile = '/settings/profile';
  static const String companySettings = '/settings/company';
  static const String notifications = '/settings/notifications';
  
  // إعدادات التوجيه
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
        
      case dashboard:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
          settings: settings,
        );
        
      case employees:
        return MaterialPageRoute(
          builder: (_) => const EmployeesScreen(),
          settings: settings,
        );
        
      case attendance:
        return MaterialPageRoute(
          builder: (_) => const AttendanceScreen(),
          settings: settings,
        );
        
      case leaves:
        return MaterialPageRoute(
          builder: (_) => const LeavesScreen(),
          settings: settings,
        );
        
      case payroll:
        return MaterialPageRoute(
          builder: (_) => const PayrollScreen(),
          settings: settings,
        );
        
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Route not found: ${settings.name}'),
            ),
          ),
          settings: settings,
        );
    }
  }
  
  // التنقل بين الشاشات
  static void navigateTo(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }
  
  // التنقل والاستبدال
  static void navigateAndReplace(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }
  
  // العودة
  static void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }
  
  // التنقل إلى الشاشة الرئيسية
  static void navigateToHome(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      dashboard,
      (route) => false,
    );
  }
  
  // التنقل إلى شاشة تسجيل الدخول
  static void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      login,
      (route) => false,
    );
  }
}