import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hr_management/core/providers/app_provider.dart';
import 'package:hr_management/features/payroll/models/payroll_model.dart';
import 'package:hr_management/core/widgets/custom_app_bar.dart';
import 'package:hr_management/core/widgets/custom_drawer.dart';

class PayrollScreen extends StatefulWidget {
  const PayrollScreen({Key? key}) : super(key: key);

  @override
  State<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedTab = 'periods'; // periods, components, salaries

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'نظام الرواتب'),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          // Tabs
          Container(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Row(
              children: [
                _buildTabButton('periods', 'فترات الرواتب'),
                _buildTabButton('components', 'مكونات الرواتب'),
                _buildTabButton('salaries', 'رواتب الموظفين'),
              ],
            ),
          ),

          // Search and Filters
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'بحث...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                if (_selectedTab == 'periods') ...[
                  DropdownButton<String>(
                    value: appProvider.payrollPeriodFilter,
                    items: const [
                      DropdownMenuItem(value: 'all', child: Text('جميع الفترات')),
                      DropdownMenuItem(value: 'open', child: Text('مفتوحة')),
                      DropdownMenuItem(value: 'closed', child: Text('مغلقة')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        appProvider.updatePayrollPeriodFilter(value);
                      }
                    },
                  ),
                ] else if (_selectedTab == 'salaries') ...[
                  DropdownButton<String>(
                    value: appProvider.paymentStatusFilter,
                    items: const [
                      DropdownMenuItem(value: 'all', child: Text('جميع الحالات')),
                      DropdownMenuItem(value: 'pending', child: Text('قيد الانتظار')),
                      DropdownMenuItem(value: 'paid', child: Text('مدفوع')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        appProvider.updatePaymentStatusFilter(value);
                      }
                    },
                  ),
                ],
              ],
            ),
          ),

          // Content
          Expanded(
            child: _buildContent(appProvider),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTabButton(String tab, String label) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          setState(() {
            _selectedTab = tab;
          });
        },
        style: TextButton.styleFrom(
          backgroundColor: _selectedTab == tab 
              ? Theme.of(context).primaryColor 
              : Colors.transparent,
          foregroundColor: _selectedTab == tab 
              ? Colors.white 
              : Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(label),
      ),
    );
  }

  Widget _buildContent(AppProvider appProvider) {
    switch (_selectedTab) {
      case 'periods':
        return _buildPayrollPeriodsList(appProvider);
      case 'components':
        return _buildSalaryComponentsList(appProvider);
      case 'salaries':
        return _buildEmployeeSalariesList(appProvider);
      default:
        return const Center(child: Text('اختر تبويباً'));
    }
  }

  Widget _buildPayrollPeriodsList(AppProvider appProvider) {
    final periods = appProvider.payrollPeriods.where((period) {
      final matchesSearch = _searchController.text.isEmpty ||
          period.name.contains(_searchController.text);
      final matchesFilter = appProvider.payrollPeriodFilter == 'all' ||
          period.status == appProvider.payrollPeriodFilter;
      return matchesSearch && matchesFilter;
    }).toList();

    if (periods.isEmpty) {
      return const Center(child: Text('لا توجد فترات رواتب'));
    }

    return ListView.builder(
      itemCount: periods.length,
      itemBuilder: (context, index) {
        final period = periods[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(period.name),
            subtitle: Text(
              'من ${period.startDate} إلى ${period.endDate}\nالحالة: ${_getStatusText(period.status)}',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showEditPeriodDialog(period),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _showDeletePeriodDialog(period.id),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSalaryComponentsList(AppProvider appProvider) {
    final components = appProvider.salaryComponents.where((component) {
      return _searchController.text.isEmpty ||
          component.name.contains(_searchController.text) ||
          component.code.contains(_searchController.text);
    }).toList();

    if (components.isEmpty) {
      return const Center(child: Text('لا توجد مكونات رواتب'));
    }

    return ListView.builder(
      itemCount: components.length,
      itemBuilder: (context, index) {
        final component = components[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text('${component.name} (${component.code})'),
            subtitle: Text(
              'النوع: ${_getComponentTypeText(component.type)}\n'
              'الحساب: ${_getCalculationTypeText(component.calculationType)}\n'
              'المبلغ: ${component.amount ?? component.percentage}',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showEditComponentDialog(component),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _showDeleteComponentDialog(component.id),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmployeeSalariesList(AppProvider appProvider) {
    final salaries = appProvider.employeeSalaries.where((salary) {
      final employee = appProvider.employees
          .firstWhere((emp) => emp.id == salary.employeeId, orElse: () => null as dynamic);
      final matchesSearch = _searchController.text.isEmpty ||
          (employee != null && employee.name.contains(_searchController.text));
      final matchesFilter = appProvider.paymentStatusFilter == 'all' ||
          salary.paymentStatus == appProvider.paymentStatusFilter;
      return matchesSearch && matchesFilter;
    }).toList();

    if (salaries.isEmpty) {
      return const Center(child: Text('لا توجد رواتب موظفين'));
    }

    return ListView.builder(
      itemCount: salaries.length,
      itemBuilder: (context, index) {
        final salary = salaries[index];
        final employee = appProvider.employees
            .firstWhere((emp) => emp.id == salary.employeeId, orElse: () => null as dynamic);
        final employeeName = employee?.name ?? 'موظف غير معروف';

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(employeeName),
            subtitle: Text(
              'الراتب الأساسي: ${salary.basicSalary}\n'
              'البدلات: ${salary.totalAllowances}\n'
              'الخصومات: ${salary.totalDeductions}\n'
              'الصافي: ${salary.netSalary}\n'
              'الحالة: ${_getPaymentStatusText(salary.paymentStatus)}',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showEditSalaryDialog(salary),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _showDeleteSalaryDialog(salary.id),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'open':
        return 'مفتوحة';
      case 'closed':
        return 'مغلقة';
      default:
        return status;
    }
  }

  String _getComponentTypeText(String type) {
    switch (type) {
      case 'basic':
        return 'أساسي';
      case 'allowance':
        return 'بدل';
      case 'deduction':
        return 'خصم';
      case 'bonus':
        return 'مكافأة';
      default:
        return type;
    }
  }

  String _getCalculationTypeText(String type) {
    switch (type) {
      case 'fixed':
        return 'ثابت';
      case 'percentage':
        return 'نسبة';
      default:
        return type;
    }
  }

  String _getPaymentStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'قيد الانتظار';
      case 'paid':
        return 'مدفوع';
      default:
        return status;
    }
  }

  void _showAddDialog() {
    switch (_selectedTab) {
      case 'periods':
        _showAddPeriodDialog();
        break;
      case 'components':
        _showAddComponentDialog();
        break;
      case 'salaries':
        _showAddSalaryDialog();
        break;
    }
  }

  void _showAddPeriodDialog() {
    // TODO: Implement add period dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('وظيفة الإضافة قيد التطوير')),
    );
  }

  void _showEditPeriodDialog(PayrollPeriod period) {
    // TODO: Implement edit period dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('وظيفة التعديل قيد التطوير')),
    );
  }

  void _showDeletePeriodDialog(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف فترة الراتب'),
        content: const Text('هل أنت متأكد من حذف هذه الفترة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<AppProvider>(context, listen: false)
                  .deletePayrollPeriod(id);
              Navigator.pop(context);
            },
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  void _showAddComponentDialog() {
    // TODO: Implement add component dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('وظيفة الإضافة قيد التطوير')),
    );
  }

  void _showEditComponentDialog(SalaryComponent component) {
    // TODO: Implement edit component dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('وظيفة التعديل قيد التطوير')),
    );
  }

  void _showDeleteComponentDialog(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف مكون الراتب'),
        content: const Text('هل أنت متأكد من حذف هذا المكون؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<AppProvider>(context, listen: false)
                  .deleteSalaryComponent(id);
              Navigator.pop(context);
            },
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  void _showAddSalaryDialog() {
    // TODO: Implement add salary dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('وظيفة الإضافة قيد التطوير')),
    );
  }

  void _showEditSalaryDialog(EmployeeSalary salary) {
    // TODO: Implement edit salary dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('وظيفة التعديل قيد التطوير')),
    );
  }

  void _showDeleteSalaryDialog(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف راتب الموظف'),
        content: const Text('هل أنت متأكد من حذف هذا الراتب؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<AppProvider>(context, listen: false)
                  .deleteEmployeeSalary(id);
              Navigator.pop(context);
            },
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
}