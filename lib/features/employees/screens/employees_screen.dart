import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_management_system/core/models/employee_model.dart';
import 'package:hr_management_system/core/models/department_model.dart';
import 'package:hr_management_system/core/providers/app_provider.dart';
import 'package:hr_management_system/core/theme/app_theme.dart';
import 'package:hr_management_system/features/employees/screens/employee_form_screen.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  String _searchQuery = '';
  String _selectedDepartment = 'all';
  String _selectedStatus = 'all';
  
  @override
  void initState() {
    super.initState();
    // تحميل البيانات عند فتح الشاشة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppProvider>().loadAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الموظفين'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement advanced search
            },
            tooltip: 'بحث متقدم',
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
            tooltip: 'تصفية',
          ),
        ],
      ),
      body: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          if (appProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (appProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: AppTheme.errorColor),
                  const SizedBox(height: 16),
                  Text(
                    'حدث خطأ: ${appProvider.error}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => appProvider.loadAllData(),
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          final filteredEmployees = _filterEmployees(appProvider.employees);

          return Column(
            children: [
              // إحصائيات سريعة
              _buildStatisticsCard(appProvider.employees, filteredEmployees),
              
              // شريط البحث والتصفية
              _buildSearchAndFilterBar(),
              
              // قائمة الموظفين
              Expanded(
                child: _buildEmployeeList(filteredEmployees, appProvider),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEmployeeForm(),
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.person_add),
        tooltip: 'إضافة موظف جديد',
      ),
    );
  }

  Widget _buildStatisticsCard(List<Employee> allEmployees, List<Employee> filteredEmployees) {
    final activeEmployees = allEmployees.where((e) => e.isActive).length;
    final totalEmployees = allEmployees.length;
    
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatisticItem('إجمالي الموظفين', totalEmployees.toString(), AppTheme.primaryColor),
            _buildStatisticItem('النشطين', activeEmployees.toString(), AppTheme.successColor),
            _buildStatisticItem('النتائج الحالية', filteredEmployees.length.toString(), AppTheme.accentColor),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilterBar() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'بحث...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
              ),
            ),
            const SizedBox(width: 16),
            DropdownButton<String>(
              value: _selectedDepartment,
              hint: const Text('القسم'),
              items: [
                const DropdownMenuItem(value: 'all', child: Text('جميع الأقسام')),
                // TODO: Add departments from provider
              ],
              onChanged: (value) {
                setState(() {
                  _selectedDepartment = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeList(List<Employee> employees, AppProvider appProvider) {
    if (employees.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'لا يوجد موظفون مطابقون للبحث',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: employees.length,
      itemBuilder: (context, index) {
        final employee = employees[index];
        return _buildEmployeeCard(employee, appProvider);
      },
    );
  }

  Widget _buildEmployeeCard(Employee employee, AppProvider appProvider) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.primaryColor,
          child: Text(
            employee.firstName[0] + employee.lastName[0],
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          employee.fullName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${employee.employeeNumber} • ${employee.jobTitle?.name ?? 'غير محدد'}'),
            Text('القسم: ${employee.department?.name ?? 'غير محدد'}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: employee.statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                employee.statusText,
                style: TextStyle(
                  color: employee.statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'view':
                    _viewEmployeeDetails(employee);
                    break;
                  case 'edit':
                    _showEmployeeForm(employee);
                    break;
                  case 'delete':
                    _confirmDeleteEmployee(employee, appProvider);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'view',
                  child: Row(
                    children: [
                      Icon(Icons.visibility, size: 20),
                      SizedBox(width: 8),
                      Text('عرض التفاصيل'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20),
                      SizedBox(width: 8),
                      Text('تعديل'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20, color: AppTheme.errorColor),
                      const SizedBox(width: 8),
                      Text('حذف', style: TextStyle(color: AppTheme.errorColor)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () => _viewEmployeeDetails(employee),
      ),
    );
  }

  List<Employee> _filterEmployees(List<Employee> employees) {
    return employees.where((employee) {
      // تصفية حسب البحث
      if (_searchQuery.isNotEmpty) {
        final searchLower = _searchQuery.toLowerCase();
        if (!employee.fullName.toLowerCase().contains(searchLower) &&
            !employee.employeeNumber.toLowerCase().contains(searchLower) &&
            !employee.email.toLowerCase().contains(searchLower)) {
          return false;
        }
      }

      // تصفية حسب القسم
      if (_selectedDepartment != 'all' && employee.department?.name != _selectedDepartment) {
        return false;
      }

      // تصفية حسب الحالة
      if (_selectedStatus != 'all' && employee.status != _selectedStatus) {
        return false;
      }

      return true;
    }).toList();
  }

  void _showEmployeeForm([Employee? employee]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmployeeFormScreen(employee: employee),
      ),
    ).then((_) {
      // إعادة تحميل البيانات بعد العودة من نموذج الإضافة/التعديل
      context.read<AppProvider>().loadAllData();
    });
  }

  void _viewEmployeeDetails(Employee employee) {
    // TODO: Implement employee details screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('عرض تفاصيل الموظف: ${employee.fullName}'),
      ),
    );
  }

  void _confirmDeleteEmployee(Employee employee, AppProvider appProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: Text('هل أنت متأكد من حذف الموظف "${employee.fullName}"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await appProvider.deleteEmployee(employee.id!);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('تم حذف الموظف بنجاح'),
                    backgroundColor: AppTheme.successColor,
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('فشل حذف الموظف: $e'),
                    backgroundColor: AppTheme.errorColor,
                  ),
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppTheme.errorColor),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    // TODO: Implement advanced filter dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('سيتم تنفيذ نظام التصفية المتقدم لاحقاً'),
      ),
    );
  }
}