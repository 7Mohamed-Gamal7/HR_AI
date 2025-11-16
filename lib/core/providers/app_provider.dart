import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hr_management_system/core/services/database_service.dart';
import 'package:hr_management_system/core/services/auth_service.dart';
import 'package:hr_management_system/core/repositories/employees_repository.dart';
import 'package:hr_management_system/features/employees/models/employee_model.dart';
import 'package:hr_management_system/features/employees/models/department_model.dart';
import 'package:hr_management_system/features/attendance/models/attendance_model.dart';
import 'package:hr_management_system/features/leaves/models/leave_model.dart';
import 'package:hr_management_system/features/payroll/models/payroll_model.dart';

class AppProvider extends ChangeNotifier {
  // حالة التحميل
  bool _isLoading = false;
  String? _error;
  
  // البيانات الأساسية
  List<Employee> _employees = [];
  List<Department> _departments = [];
  List<JobTitle> _jobTitles = [];
  List<AttendanceRecord> _attendanceRecords = [];
  List<AttendanceRule> _attendanceRules = [];
  List<LeaveRequest> _leaveRequests = [];
  List<LeaveType> _leaveTypes = [];
  
  // التصفية والبحث
  String _searchQuery = '';
  String? _selectedDepartment;
  String? _selectedStatus;
  
  // فلاتر الحضور والانصراف
  DateTime _selectedAttendanceDate = DateTime.now();
  String _attendanceStatusFilter = 'all';
  
  // فلاتر الإجازات
  String _leaveStatusFilter = 'all';
  String _leaveTypeFilter = 'all';

  //----------------------------------------------------------------------------
  // Payroll
  //----------------------------------------------------------------------------

  List<PayrollPeriod> _payrollPeriods = [];
  List<SalaryComponent> _salaryComponents = [];
  List<EmployeeSalary> _employeeSalaries = [];
  String _payrollPeriodFilter = 'all';
  String _paymentStatusFilter = 'all';

  //----------------------------------------------------------------------------
  // Payroll Methods
  //----------------------------------------------------------------------------

  // تحميل فترات الرواتب
  Future<void> loadPayrollPeriods() async {
    try {
      final db = await DatabaseService.instance.database;
      final List<Map<String, dynamic>> maps = await db.query('payroll_periods');
      _payrollPeriods = maps.map((map) => PayrollPeriod.fromMap(map)).toList();
      notifyListeners();
    } catch (e) {
      setError('خطأ في تحميل فترات الرواتب: $e');
    }
  }

  // تحميل مكونات الرواتب
  Future<void> loadSalaryComponents() async {
    try {
      final db = await DatabaseService.instance.database;
      final List<Map<String, dynamic>> maps = await db.query('salary_components');
      _salaryComponents = maps.map((map) => SalaryComponent.fromMap(map)).toList();
      notifyListeners();
    } catch (e) {
      setError('خطأ في تحميل مكونات الرواتب: $e');
    }
  }

  // تحميل رواتب الموظفين
  Future<void> loadEmployeeSalaries() async {
    try {
      final db = await DatabaseService.instance.database;
      final List<Map<String, dynamic>> maps = await db.query('employee_salaries');
      _employeeSalaries = maps.map((map) => EmployeeSalary.fromMap(map)).toList();
      notifyListeners();
    } catch (e) {
      setError('خطأ في تحميل رواتب الموظفين: $e');
    }
  }

  // إضافة فترة راتب
  Future<void> addPayrollPeriod(PayrollPeriod period) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.insert('payroll_periods', period.toMap());
      await loadPayrollPeriods();
    } catch (e) {
      setError('خطأ في إضافة فترة الراتب: $e');
    }
  }

  // تحديث فترة راتب
  Future<void> updatePayrollPeriod(PayrollPeriod period) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.update(
        'payroll_periods',
        period.toMap(),
        where: 'id = ?',
        whereArgs: [period.id],
      );
      await loadPayrollPeriods();
    } catch (e) {
      setError('خطأ في تحديث فترة الراتب: $e');
    }
  }

  // حذف فترة راتب
  Future<void> deletePayrollPeriod(int id) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.delete(
        'payroll_periods',
        where: 'id = ?',
        whereArgs: [id],
      );
      await loadPayrollPeriods();
    } catch (e) {
      setError('خطأ في حذف فترة الراتب: $e');
    }
  }

  // إضافة مكون راتب
  Future<void> addSalaryComponent(SalaryComponent component) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.insert('salary_components', component.toMap());
      await loadSalaryComponents();
    } catch (e) {
      setError('خطأ في إضافة مكون الراتب: $e');
    }
  }

  // تحديث مكون راتب
  Future<void> updateSalaryComponent(SalaryComponent component) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.update(
        'salary_components',
        component.toMap(),
        where: 'id = ?',
        whereArgs: [component.id],
      );
      await loadSalaryComponents();
    } catch (e) {
      setError('خطأ في تحديث مكون الراتب: $e');
    }
  }

  // حذف مكون راتب
  Future<void> deleteSalaryComponent(int id) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.delete(
        'salary_components',
        where: 'id = ?',
        whereArgs: [id],
      );
      await loadSalaryComponents();
    } catch (e) {
      setError('خطأ في حذف مكون الراتب: $e');
    }
  }

  // إضافة راتب موظف
  Future<void> addEmployeeSalary(EmployeeSalary salary) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.insert('employee_salaries', salary.toMap());
      await loadEmployeeSalaries();
    } catch (e) {
      setError('خطأ في إضافة راتب الموظف: $e');
    }
  }

  // تحديث راتب موظف
  Future<void> updateEmployeeSalary(EmployeeSalary salary) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.update(
        'employee_salaries',
        salary.toMap(),
        where: 'id = ?',
        whereArgs: [salary.id],
      );
      await loadEmployeeSalaries();
    } catch (e) {
      setError('خطأ في تحديث راتب الموظف: $e');
    }
  }

  // حذف راتب موظف
  Future<void> deleteEmployeeSalary(int id) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.delete(
        'employee_salaries',
        where: 'id = ?',
        whereArgs: [id],
      );
      await loadEmployeeSalaries();
    } catch (e) {
      setError('خطأ في حذف راتب الموظف: $e');
    }
  }
  
  // الترقيم والصفحات
  int _currentPage = 1;
  int _itemsPerPage = 10;
  int _totalItems = 0;
  
  // getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Employee> get employees => _employees;
  List<Department> get departments => _departments;
  List<JobTitle> get jobTitles => _jobTitles;
  List<AttendanceRecord> get attendanceRecords => _attendanceRecords;
  List<AttendanceRule> get attendanceRules => _attendanceRules;
  
  String get searchQuery => _searchQuery;
  int? get selectedDepartmentId => _selectedDepartmentId;
  String get selectedStatus => _selectedStatus;
  
  DateTime get selectedAttendanceDate => _selectedAttendanceDate;
  String get attendanceStatusFilter => _attendanceStatusFilter;

  // Getters for Leaves
  List<LeaveType> get leaveTypes => _leaveTypes;
  List<LeaveRequest> get leaveRequests => _leaveRequests; // You might want to filter this
  String get leaveStatusFilter => _leaveStatusFilter;
  String get leaveTypeFilter => _leaveTypeFilter;

  //----------------------------------------------------------------------------
  // Payroll Getters
  //----------------------------------------------------------------------------

  List<PayrollPeriod> get payrollPeriods => _payrollPeriods;
  List<SalaryComponent> get salaryComponents => _salaryComponents;
  List<EmployeeSalary> get employeeSalaries => _employeeSalaries;
  String get payrollPeriodFilter => _payrollPeriodFilter;
  String get paymentStatusFilter => _paymentStatusFilter;
  int get currentPage => _currentPage;
  int get itemsPerPage => _itemsPerPage;
  int get totalItems => _totalItems;
  int get totalPages => (_totalItems / _itemsPerPage).ceil();
  
  // قائمة الموظفين المصفاة
  List<Employee> get filteredEmployees {
    var filtered = _employees;
    
    // تصفية حسب البحث
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((employee) {
        return employee.fullName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               employee.employeeNumber.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               (employee.email?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
               (employee.phone?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
      }).toList();
    }
    
    // تصفية حسب القسم
    if (_selectedDepartment != null && _selectedDepartment!.isNotEmpty) {
      filtered = filtered.where((employee) {
        return employee.departmentId == _selectedDepartment;
      }).toList();
    }
    
    // تصفية حسب الحالة
    if (_selectedStatus != null && _selectedStatus!.isNotEmpty) {
      filtered = filtered.where((employee) {
        return employee.status == _selectedStatus;
      }).toList();
    }
    
    _totalItems = filtered.length;
    
    // الترقيم
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    
    if (startIndex >= filtered.length) {
      return [];
    }
    
    return filtered.sublist(
      startIndex,
      endIndex > filtered.length ? filtered.length : endIndex,
    );
  }
  
  // تعيين حالة التحميل
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Functions to update leave filters// فلاتر الإجازات
  void updateLeaveStatusFilter(String status) {
    _leaveStatusFilter = status;
    notifyListeners();
  }

  void updateLeaveTypeFilter(String type) {
    _leaveTypeFilter = type;
    notifyListeners();
  }

  //----------------------------------------------------------------------------
  // Payroll Filter Methods
  //----------------------------------------------------------------------------

  void updatePayrollPeriodFilter(String period) {
    _payrollPeriodFilter = period;
    notifyListeners();
  }

  void updatePaymentStatusFilter(String status) {
    _paymentStatusFilter = status;
    notifyListeners();
  }

  // تعيين الخطأ
  void setError(String? error) {
    _error = error;
    notifyListeners();
  }
  
  // تعيين استعلام البحث
  void setSearchQuery(String query) {
    _searchQuery = query;
    _currentPage = 1; // إعادة التعيين إلى الصفحة الأولى
    notifyListeners();
  }
  
  // تعيين القسم المحدد
  void setSelectedDepartment(String? departmentId) {
    _selectedDepartment = departmentId;
    _currentPage = 1;
    notifyListeners();
  }
  
  // تعيين الحالة المحددة
  void updateSelectedStatus(String status) {
    _selectedStatus = status;
    _currentPage = 1;
    notifyListeners();
  }

  void updateAttendanceDate(DateTime date) {
    _selectedAttendanceDate = date;
    notifyListeners();
  }

  void updateAttendanceStatusFilter(String status) {
    _attendanceStatusFilter = status;
    notifyListeners();
  }
  
  // تعيين الصفحة الحالية
  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }
  
  // تعيين عدد العناصر لكل صفحة
  void setItemsPerPage(int itemsPerPage) {
    _itemsPerPage = itemsPerPage;
    _currentPage = 1;
    notifyListeners();
  }
  
  // تحميل الموظفين
  Future<void> loadEmployees() async {
    try {
      setLoading(true);
      setError(null);
      
      final db = await DatabaseService.instance.database;
      final employeeMaps = await db.query('employees');
      
      _employees = employeeMaps.map((map) => Employee.fromMap(map)).toList();
      
      // تحميل العلاقات
      for (var employee in _employees) {
        if (employee.departmentId != null) {
          final departmentMaps = await db.query(
            'departments',
            where: 'id = ?',
            whereArgs: [employee.departmentId],
          );
          if (departmentMaps.isNotEmpty) {
            employee.department = Department.fromMap(departmentMaps.first);
          }
        }
        
        if (employee.jobTitleId != null) {
          final jobTitleMaps = await db.query(
            'job_titles',
            where: 'id = ?',
            whereArgs: [employee.jobTitleId],
          );
          if (jobTitleMaps.isNotEmpty) {
            employee.jobTitle = JobTitle.fromMap(jobTitleMaps.first);
          }
        }
        
        if (employee.managerId != null) {
          final managerMaps = await db.query(
            'employees',
            where: 'id = ?',
            whereArgs: [employee.managerId],
          );
          if (managerMaps.isNotEmpty) {
            employee.manager = Employee.fromMap(managerMaps.first);
          }
        }
      }
      
      setLoading(false);
    } catch (e) {
      setError('فشل تحميل بيانات الموظفين: $e');
      setLoading(false);
    }
  }
  
  // تحميل الأقسام
  Future<void> loadDepartments() async {
    try {
      final db = await DatabaseService.instance.database;
      final departmentMaps = await db.query('departments');
      
      _departments = departmentMaps.map((map) => Department.fromMap(map)).toList();
      
      // تحميل العلاقات
      for (var department in _departments) {
        if (department.managerId != null) {
          final managerMaps = await db.query(
            'employees',
            where: 'id = ?',
            whereArgs: [department.managerId],
          );
          if (managerMaps.isNotEmpty) {
            department.manager = Employee.fromMap(managerMaps.first);
          }
        }
      }
      
      notifyListeners();
    } catch (e) {
      setError('فشل تحميل بيانات الأقسام: $e');
    }
  }
  
  // تحميل المسميات الوظيفية
  Future<void> loadJobTitles() async {
    try {
      final db = await DatabaseService.instance.database;
      final jobTitleMaps = await db.query('job_titles');
      
      _jobTitles = jobTitleMaps.map((map) => JobTitle.fromMap(map)).toList();
      
      // تحميل العلاقات
      for (var jobTitle in _jobTitles) {
        if (jobTitle.departmentId != null) {
          final departmentMaps = await db.query(
            'departments',
            where: 'id = ?',
            whereArgs: [jobTitle.departmentId],
          );
          if (departmentMaps.isNotEmpty) {
            jobTitle.department = Department.fromMap(departmentMaps.first);
          }
        }
      }
      
      notifyListeners();
    } catch (e) {
      setError('فشل تحميل بيانات المسميات الوظيفية: $e');
    }
  }
  
  // تحميل سجلات الحضور
  Future<void> loadAttendanceRecords() async {
    try {
      final db = await DatabaseService.instance.database;
      final recordMaps = await db.query('attendance_records');
      _attendanceRecords = recordMaps.map((map) => AttendanceRecord.fromMap(map)).toList();
      notifyListeners();
    } catch (e) {
      setError('فشل تحميل سجلات الحضور: $e');
    }
  }

  // تحميل قواعد الحضور
  Future<void> loadAttendanceRules() async {
    try {
      final db = await DatabaseService.instance.database;
      final ruleMaps = await db.query('attendance_rules');
      _attendanceRules = ruleMaps.map((map) => AttendanceRule.fromMap(map)).toList();
      notifyListeners();
    } catch (e) {
      setError('فشل تحميل قواعد الحضور: $e');
    }
  }
  
  // إضافة موظف جديد
  Future<bool> addEmployee(Employee employee) async {
    try {
      final db = await DatabaseService.instance.database;
      
      await db.insert('employees', employee.toMap());
      
      await loadEmployees();
      return true;
    } catch (e) {
      setError('فشل إضافة الموظف: $e');
      return false;
    }
  }
  
  // تحديث بيانات موظف
  Future<bool> updateEmployee(Employee employee) async {
    try {
      final db = await DatabaseService.instance.database;
      
      await db.update(
        'employees',
        employee.toMap(),
        where: 'id = ?',
        whereArgs: [employee.id],
      );
      
      await loadEmployees();
      return true;
    } catch (e) {
      setError('فشل تحديث بيانات الموظف: $e');
      return false;
    }
  }
  
  // حذف موظف
  Future<bool> deleteEmployee(String employeeId) async {
    try {
      final db = await DatabaseService.instance.database;
      
      await db.delete(
        'employees',
        where: 'id = ?',
        whereArgs: [employeeId],
      );
      
      await loadEmployees();
      return true;
    } catch (e) {
      setError('فشل حذف الموظف: $e');
      return false;
    }
  }
  
  // إضافة قسم جديد
  Future<bool> addDepartment(Department department) async {
    try {
      final db = await DatabaseService.instance.database;
      
      await db.insert('departments', department.toMap());
      
      await loadDepartments();
      return true;
    } catch (e) {
      setError('فشل إضافة القسم: $e');
      return false;
    }
  }
  
  // تحديث بيانات قسم
  Future<bool> updateDepartment(Department department) async {
    try {
      final db = await DatabaseService.instance.database;
      
      await db.update(
        'departments',
        department.toMap(),
        where: 'id = ?',
        whereArgs: [department.id],
      );
      
      await loadDepartments();
      return true;
    } catch (e) {
      setError('فشل تحديث بيانات القسم: $e');
      return false;
    }
  }
  
  // إضافة مسمى وظيفي جديد
  Future<bool> addJobTitle(JobTitle jobTitle) async {
    try {
      final db = await DatabaseService.instance.database;
      
      await db.insert('job_titles', jobTitle.toMap());
      
      await loadJobTitles();
      return true;
    } catch (e) {
      setError('فشل إضافة المسمى الوظيفي: $e');
      return false;
    }
  }
  
  // تحديث بيانات مسمى وظيفي
  Future<bool> updateJobTitle(JobTitle jobTitle) async {
    try {
      final db = await DatabaseService.instance.database;
      
      await db.update(
        'job_titles',
        jobTitle.toMap(),
        where: 'id = ?',
        whereArgs: [jobTitle.id],
      );
      
      await loadJobTitles();
      return true;
    } catch (e) {
      setError('فشل تحديث بيانات المسمى الوظيفي: $e');
      return false;
    }
  }
  
  // إضافة سجل حضور جديد
  Future<bool> addAttendanceRecord(AttendanceRecord record) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.insert('attendance_records', record.toMap());
      await loadAttendanceRecords();
      return true;
    } catch (e) {
      setError('فشل إضافة سجل الحضور: $e');
      return false;
    }
  }

  // تحديث سجل حضور
  Future<bool> updateAttendanceRecord(AttendanceRecord record) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.update(
        'attendance_records',
        record.toMap(),
        where: 'id = ?',
        whereArgs: [record.id],
      );
      await loadAttendanceRecords();
      return true;
    } catch (e) {
      setError('فشل تحديث سجل الحضور: $e');
      return false;
    }
  }

  // حذف سجل حضور
  Future<bool> deleteAttendanceRecord(String recordId) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.delete(
        'attendance_records',
        where: 'id = ?',
        whereArgs: [recordId],
      );
      await loadAttendanceRecords();
      return true;
    } catch (e) {
      setError('فشل حذف سجل الحضور: $e');
      return false;
    }
  }
  
  // إضافة قاعدة حضور جديدة
  Future<bool> addAttendanceRule(AttendanceRule rule) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.insert('attendance_rules', rule.toMap());
      await loadAttendanceRules();
      return true;
    } catch (e) {
      setError('فشل إضافة قاعدة الحضور: $e');
      return false;
    }
  }

  // تحديث قاعدة حضور
  Future<bool> updateAttendanceRule(AttendanceRule rule) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.update(
        'attendance_rules',
        rule.toMap(),
        where: 'id = ?',
        whereArgs: [rule.id],
      );
      await loadAttendanceRules();
      return true;
    } catch (e) {
      setError('فشل تحديث قاعدة الحضور: $e');
      return false;
    }
  }

  // حذف قاعدة حضور
  Future<bool> deleteAttendanceRule(String ruleId) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.delete(
        'attendance_rules',
        where: 'id = ?',
        whereArgs: [ruleId],
      );
      await loadAttendanceRules();
      return true;
    } catch (e) {
      setError('فشل حذف قاعدة الحضور: $e');
      return false;
    }
  }

  // إضافة نوع إجازة
  Future<bool> addLeaveType(LeaveType leaveType) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.insert('leave_types', leaveType.toMap());
      await loadLeaveTypes();
      return true;
    } catch (e) {
      setError('فشل إضافة نوع الإجازة: $e');
      return false;
    }
  }

  // تحديث نوع إجازة
  Future<bool> updateLeaveType(LeaveType leaveType) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.update(
        'leave_types',
        leaveType.toMap(),
        where: 'id = ?',
        whereArgs: [leaveType.id],
      );
      await loadLeaveTypes();
      return true;
    } catch (e) {
      setError('فشل تحديث نوع الإجازة: $e');
      return false;
    }
  }

  // حذف نوع إجازة
  Future<bool> deleteLeaveType(String leaveTypeId) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.delete(
        'leave_types',
        where: 'id = ?',
        whereArgs: [leaveTypeId],
      );
      await loadLeaveTypes();
      return true;
    } catch (e) {
      setError('فشل حذف نوع الإجازة: $e');
      return false;
    }
  }

  // إضافة طلب إجازة
  Future<bool> addLeaveRequest(LeaveRequest leaveRequest) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.insert('leave_requests', leaveRequest.toMap());
      await loadLeaveRequests();
      return true;
    } catch (e) {
      setError('فشل إضافة طلب الإجازة: $e');
      return false;
    }
  }

  // تحديث طلب إجازة
  Future<bool> updateLeaveRequest(LeaveRequest leaveRequest) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.update(
        'leave_requests',
        leaveRequest.toMap(),
        where: 'id = ?',
        whereArgs: [leaveRequest.id],
      );
      await loadLeaveRequests();
      return true;
    } catch (e) {
      setError('فشل تحديث طلب الإجازة: $e');
      return false;
    }
  }

  // حذف طلب إجازة
  Future<bool> deleteLeaveRequest(String leaveRequestId) async {
    try {
      final db = await DatabaseService.instance.database;
      await db.delete(
        'leave_requests',
        where: 'id = ?',
        whereArgs: [leaveRequestId],
      );
      await loadLeaveRequests();
      return true;
    } catch (e) {
      setError('فشل حذف طلب الإجازة: $e');
      return false;
    }
  }

  // تحميل أنواع الإجازات
  Future<void> loadLeaveTypes() async {
    try {
      final db = await DatabaseService.instance.database;
      final data = await db.query('leave_types');
      _leaveTypes = data.map((e) => LeaveType.fromMap(e)).toList();
      notifyListeners();
    } catch (e) {
      setError('فشل تحميل أنواع الإجازات: $e');
    }
  }

  // تحميل طلبات الإجازات
  Future<void> loadLeaveRequests() async {
    try {
      final db = await DatabaseService.instance.database;
      final data = await db.query('leave_requests');
      _leaveRequests = data.map((e) => LeaveRequest.fromMap(e)).toList();
      notifyListeners();
    } catch (e) {
      setError('فشل تحميل طلبات الإجازات: $e');
    }
  }
  
  // إعادة تعيين الفلاتر
  void resetFilters() {
    _searchQuery = '';
    _selectedDepartment = null;
    _selectedStatus = null;
    _currentPage = 1;
    notifyListeners();
  }
  
  // تحميل جميع البيانات
  Future<void> loadAllData() async {
    await Future.wait([
      loadEmployees(),
      loadDepartments(),
      loadJobTitles(),
      loadAttendanceRecords(),
      loadAttendanceRules(),
      loadLeaveTypes(),
      loadLeaveRequests(),
      // تحميل بيانات الرواتب
      loadPayrollPeriods(),
      loadSalaryComponents(),
      loadEmployeeSalaries(),
    ]);
  }
}
  final EmployeesRepository _employeesRepository = EmployeesRepository();

  Future<void> loadEmployeesRemote({Map<String, dynamic>? query}) async {
    _setLoading(true);
    try {
      final list = await _employeesRepository.list(query: query);
      _employees = list;
      _totalItems = list.length;
      notifyListeners();
    } catch (e) {
      setError('خطأ في تحميل الموظفين من الخادم: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }