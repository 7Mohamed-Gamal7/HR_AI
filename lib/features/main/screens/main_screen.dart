import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_management_system/core/services/auth_service.dart';
import 'package:hr_management_system/core/routes/app_routes.dart';
import 'package:hr_management_system/core/theme/app_theme.dart';
import 'package:hr_management_system/core/providers/app_provider.dart';
import 'package:hr_ai/features/employees/screens/employees_screen.dart';
import 'package:hr_ai/features/attendance/screens/attendance_screen.dart';
import 'package:hr_ai/features/leaves/screens/leaves_screen.dart';
import 'package:hr_ai/features/payroll/screens/payroll_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _isLoading = true;
  String? _errorMessage;

  final List<NavigationDestination> _destinations = [
    const NavigationDestination(
      icon: Icon(Icons.dashboard_outlined),
      selectedIcon: Icon(Icons.dashboard),
      label: 'الرئيسية',
    ),
    const NavigationDestination(
      icon: Icon(Icons.people_outline),
      selectedIcon: Icon(Icons.people),
      label: 'الموظفين',
    ),
    const NavigationDestination(
      icon: Icon(Icons.fingerprint_outlined),
      selectedIcon: Icon(Icons.fingerprint),
      label: 'الحضور',
    ),
    const NavigationDestination(
      icon: Icon(Icons.beach_access_outlined),
      selectedIcon: Icon(Icons.beach_access),
      label: 'الإجازات',
    ),
    const NavigationDestination(
      icon: Icon(Icons.attach_money_outlined),
      selectedIcon: Icon(Icons.attach_money),
      label: 'المرتبات',
    ),
  ];

  final List<Widget> _pages = [
    const DashboardScreen(),
    const EmployeesScreen(),
    const AttendanceScreen(),
    const LeavesScreen(),
    const PayrollScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      final appProvider = context.read<AppProvider>();
      await appProvider.loadAllData();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'حدث خطأ أثناء تحميل البيانات';
      });
    }
  }

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد تسجيل الخروج'),
        content: const Text('هل أنت متأكد من أنك تريد تسجيل الخروج؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('تسجيل الخروج'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final authService = context.read<AuthService>();
      await authService.logout();
      if (mounted) {
        AppRoutes.navigateToLogin(context);
      }
    }
  }

  void _openSettings() {
    // TODO: فتح شاشة الإعدادات
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('قريباً: شاشة الإعدادات')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'جاري تحميل البيانات...',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: AppTheme.errorColor,
              ),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadInitialData,
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_destinations[_selectedIndex].label),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: فتح شاشة الإشعارات
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('قريباً: الإشعارات')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: _openSettings,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                _logout();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, size: 20),
                    SizedBox(width: 8),
                    Text('تسجيل الخروج'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Row(
        children: [
          // Navigation Rail للشاشات الكبيرة
          if (MediaQuery.of(context).size.width >= 600)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onItemSelected,
              labelType: NavigationRailLabelType.all,
              backgroundColor: AppTheme.cardColor,
              selectedIconTheme:
                  const IconThemeData(color: AppTheme.primaryColor),
              selectedLabelTextStyle:
                  const TextStyle(color: AppTheme.primaryColor),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard),
                  label: Text('الرئيسية'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.people_outline),
                  selectedIcon: Icon(Icons.people),
                  label: Text('الموظفين'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.fingerprint_outlined),
                  selectedIcon: Icon(Icons.fingerprint),
                  label: Text('الحضور'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.beach_access_outlined),
                  selectedIcon: Icon(Icons.beach_access),
                  label: Text('الإجازات'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.attach_money_outlined),
                  selectedIcon: Icon(Icons.attach_money),
                  label: Text('المرتبات'),
                ),
              ],
            ),

          // المحتوى الرئيسي
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),

      // Bottom Navigation Bar للشاشات الصغيرة
      bottomNavigationBar: MediaQuery.of(context).size.width < 600
          ? NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onItemSelected,
              destinations: _destinations,
            )
          : null,
    );
  }
}

// شاشات مؤقتة للمحتوى
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // بطاقات الإحصائيات
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount:
                    MediaQuery.of(context).size.width >= 600 ? 4 : 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildStatCard(
                    context,
                    title: 'إجمالي الموظفين',
                    value: appProvider.employees.length.toString(),
                    icon: Icons.people,
                    color: AppTheme.primaryColor,
                  ),
                  _buildStatCard(
                    context,
                    title: 'الأقسام',
                    value: appProvider.departments.length.toString(),
                    icon: Icons.domain,
                    color: AppTheme.secondaryColor,
                  ),
                  _buildStatCard(
                    context,
                    title: 'الحضور اليوم',
                    value: '0',
                    icon: Icons.fingerprint,
                    color: AppTheme.successColor,
                  ),
                  _buildStatCard(
                    context,
                    title: 'الإجازات',
                    value: '0',
                    icon: Icons.beach_access,
                    color: AppTheme.warningColor,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // أحدث الموظفين
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'أحدث الموظفين',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      if (appProvider.employees.isEmpty)
                        const Center(
                          child: Text('لا يوجد موظفون مسجلون حتى الآن'),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: appProvider.employees.take(5).length,
                          itemBuilder: (context, index) {
                            final employee = appProvider.employees[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: AppTheme.primaryColor,
                                child: Text(
                                  employee.fullName.characters.first,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(employee.fullName),
                              subtitle:
                                  Text(employee.jobTitle?.name ?? 'غير محدد'),
                              trailing: Text(
                                employee.employeeNumber,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('قريباً: شاشة إدارة الموظفين'),
    );
  }
}

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('قريباً: شاشة الحضور والانصراف'),
    );
  }
}

class LeavesScreen extends StatelessWidget {
  const LeavesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('قريباً: شاشة الإجازات'),
    );
  }
}

class PayrollScreen extends StatelessWidget {
  const PayrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('قريباً: شاشة المرتبات'),
    );
  }
}
