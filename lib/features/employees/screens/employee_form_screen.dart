import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_management_system/core/models/employee_model.dart';
import 'package:hr_management_system/core/models/department_model.dart';
import 'package:hr_management_system/core/providers/app_provider.dart';
import 'package:hr_management_system/core/theme/app_theme.dart';
import 'package:intl/intl.dart';

class EmployeeFormScreen extends StatefulWidget {
  final Employee? employee;
  
  const EmployeeFormScreen({super.key, this.employee});

  @override
  State<EmployeeFormScreen> createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _employeeNumberController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _salaryController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _emergencyPhoneController = TextEditingController();
  
  DateTime? _dateOfBirth;
  DateTime? _hireDate;
  String? _selectedGender;
  String? _selectedNationality;
  Department? _selectedDepartment;
  JobTitle? _selectedJobTitle;
  Employee? _selectedManager;
  String? _selectedEmploymentType;
  String? _selectedStatus;
  bool _isLoading = false;
  
  final List<String> _genders = ['male', 'female'];
  final List<String> _nationalities = [
    'سعودي', 'مصري', 'سوري', 'لبناني', 'أردني', 'عراقي', 'يمني', 'سوداني',
    'مغربي', 'تونسي', 'جزائري', 'ليبي', 'كويتي', 'إماراتي', 'قطري', 'بحريني',
    'عماني', 'أمريكي', 'بريطاني', 'فرنسي', 'ألماني', 'صيني', 'هندي', 'باكستاني'
  ];
  final List<String> _employmentTypes = ['دوام كامل', 'دوام جزئي', 'عقد', 'مؤقت', 'تدريب'];
  final List<String> _statuses = ['نشط', 'غير نشط', 'في إجازة', 'مستقيل', 'مفصول'];

  @override
  void initState() {
    super.initState();
    if (widget.employee != null) {
      _populateFormData();
    } else {
      // تعيين قيم افتراضية للموظف الجديد
      _selectedStatus = 'نشط';
      _selectedEmploymentType = 'دوام كامل';
      _hireDate = DateTime.now();
    }
  }

  void _populateFormData() {
    final employee = widget.employee!;
    _employeeNumberController.text = employee.employeeNumber;
    _firstNameController.text = employee.firstName;
    _lastNameController.text = employee.lastName;
    _emailController.text = employee.email;
    _phoneController.text = employee.phone;
    _addressController.text = employee.address ?? '';
    _salaryController.text = employee.salary?.toString() ?? '';
    _emergencyContactController.text = employee.emergencyContactName ?? '';
    _emergencyPhoneController.text = employee.emergencyContactPhone ?? '';
    
    _dateOfBirth = employee.dateOfBirth;
    _hireDate = employee.hireDate;
    _selectedGender = employee.gender;
    _selectedNationality = employee.nationality;
    _selectedDepartment = employee.department;
    _selectedJobTitle = employee.jobTitle;
    _selectedManager = employee.manager;
    _selectedEmploymentType = employee.employmentType;
    _selectedStatus = employee.status;
  }

  @override
  void dispose() {
    _employeeNumberController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _salaryController.dispose();
    _emergencyContactController.dispose();
    _emergencyPhoneController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isBirthDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isBirthDate ? (_dateOfBirth ?? DateTime.now().subtract(const Duration(days: 6570))) : (_hireDate ?? DateTime.now()),
      firstDate: isBirthDate ? DateTime(1950) : DateTime(2000),
      lastDate: isBirthDate ? DateTime.now().subtract(const Duration(days: 6570)) : DateTime(2050),
    );
    
    if (picked != null) {
      setState(() {
        if (isBirthDate) {
          _dateOfBirth = picked;
        } else {
          _hireDate = picked;
        }
      });
    }
  }

  Future<void> _saveEmployee() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final appProvider = context.read<AppProvider>();
      
      final employeeData = Employee(
        id: widget.employee?.id,
        employeeNumber: _employeeNumberController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim().isEmpty ? null : _addressController.text.trim(),
        dateOfBirth: _dateOfBirth,
        gender: _selectedGender,
        nationality: _selectedNationality,
        hireDate: _hireDate ?? DateTime.now(),
        salary: double.tryParse(_salaryController.text),
        employmentType: _selectedEmploymentType,
        status: _selectedStatus ?? 'نشط',
        department: _selectedDepartment,
        jobTitle: _selectedJobTitle,
        manager: _selectedManager,
        emergencyContactName: _emergencyContactController.text.trim().isEmpty ? null : _emergencyContactController.text.trim(),
        emergencyContactPhone: _emergencyPhoneController.text.trim().isEmpty ? null : _emergencyPhoneController.text.trim(),
        createdAt: widget.employee?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (widget.employee == null) {
        await appProvider.addEmployee(employeeData);
      } else {
        await appProvider.updateEmployee(employeeData);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.employee == null 
              ? 'تم إضافة الموظف بنجاح' 
              : 'تم تعديل بيانات الموظف بنجاح'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    final appProvider = context.watch<AppProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.employee == null ? 'إضافة موظف جديد' : 'تعديل بيانات الموظف'),
        actions: [
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveEmployee,
              tooltip: 'حفظ',
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // المعلومات الأساسية
              _buildSectionHeader('المعلومات الأساسية'),
              const SizedBox(height: 16),
              
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _employeeNumberController,
                      decoration: const InputDecoration(
                        labelText: 'رقم الموظف *',
                        hintText: 'EMP001',
                        prefixIcon: Icon(Icons.badge),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'يرجى إدخال رقم الموظف';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedStatus,
                      decoration: const InputDecoration(
                        labelText: 'الحالة *',
                        prefixIcon: Icon(Icons.info_outline),
                      ),
                      items: _statuses.map((status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'يرجى اختيار الحالة';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'الاسم الأول *',
                        hintText: 'أحمد',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'يرجى إدخال الاسم الأول';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'اسم العائلة *',
                        hintText: 'محمد',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'يرجى إدخال اسم العائلة';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: const InputDecoration(
                        labelText: 'الجنس *',
                        prefixIcon: Icon(Icons.wc),
                      ),
                      items: _genders.map((gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text(gender == 'male' ? 'ذكر' : 'أنثى'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'يرجى اختيار الجنس';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context, true),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'تاريخ الميلاد',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Text(
                          _dateOfBirth == null 
                            ? 'اختر التاريخ' 
                            : DateFormat('yyyy-MM-dd').format(_dateOfBirth!),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                value: _selectedNationality,
                decoration: const InputDecoration(
                  labelText: 'الجنسية',
                  prefixIcon: Icon(Icons.flag),
                ),
                items: _nationalities.map((nationality) {
                  return DropdownMenuItem(
                    value: nationality,
                    child: Text(nationality),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedNationality = value;
                  });
                },
              ),
              
              const SizedBox(height: 24),
              
              // معلومات الاتصال
              _buildSectionHeader('معلومات الاتصال'),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني *',
                  hintText: 'employee@company.com',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'يرجى إدخال البريد الإلكتروني';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'يرجى إدخال بريد إلكتروني صحيح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف *',
                  hintText: '0501234567',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'يرجى إدخال رقم الهاتف';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'العنوان',
                  hintText: 'الشارع، المدينة، الرمز البريدي',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
                maxLines: 2,
              ),
              
              const SizedBox(height: 24),
              
              // معلومات التوظيف
              _buildSectionHeader('معلومات التوظيف'),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<Department>(
                      value: _selectedDepartment,
                      decoration: const InputDecoration(
                        labelText: 'القسم *',
                        prefixIcon: Icon(Icons.domain),
                      ),
                      items: appProvider.departments.map((department) {
                        return DropdownMenuItem(
                          value: department,
                          child: Text(department.name),
                        );
                      }).toList(),
                      onChanged: (department) {
                        setState(() {
                          _selectedDepartment = department;
                          _selectedJobTitle = null; // إعادة تعيين المسمى الوظيفي
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'يرجى اختيار القسم';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<JobTitle>(
                      value: _selectedJobTitle,
                      decoration: const InputDecoration(
                        labelText: 'المسمى الوظيفي *',
                        prefixIcon: Icon(Icons.work_outline),
                      ),
                      items: _selectedDepartment?.jobTitles.map((jobTitle) {
                        return DropdownMenuItem(
                          value: jobTitle,
                          child: Text(jobTitle.name),
                        );
                      }).toList() ?? [],
                      onChanged: (jobTitle) {
                        setState(() {
                          _selectedJobTitle = jobTitle;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'يرجى اختيار المسمى الوظيفي';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedEmploymentType,
                      decoration: const InputDecoration(
                        labelText: 'نوع التوظيف *',
                        prefixIcon: Icon(Icons.work),
                      ),
                      items: _employmentTypes.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedEmploymentType = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'يرجى اختيار نوع التوظيف';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context, false),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'تاريخ التعيين *',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Text(
                          _hireDate == null 
                            ? 'اختر التاريخ' 
                            : DateFormat('yyyy-MM-dd').format(_hireDate!),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _salaryController,
                decoration: const InputDecoration(
                  labelText: 'المرتب الأساسي *',
                  hintText: '5000',
                  prefixIcon: Icon(Icons.attach_money),
                  suffixText: 'ريال',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'يرجى إدخال المرتب الأساسي';
                  }
                  if (double.tryParse(value) == null) {
                    return 'يرجى إدخال رقم صحيح';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              DropdownButtonFormField<Employee>(
                value: _selectedManager,
                decoration: const InputDecoration(
                  labelText: 'المدير المباشر',
                  prefixIcon: Icon(Icons.supervisor_account),
                ),
                items: [
                  const DropdownMenuItem<Employee>(
                    value: null,
                    child: Text('بدون مدير مباشر'),
                  ),
                  ...appProvider.employees.map((employee) {
                    return DropdownMenuItem(
                      value: employee,
                      child: Text('${employee.employeeNumber} - ${employee.fullName}'),
                    );
                  }),
                ],
                onChanged: (manager) {
                  setState(() {
                    _selectedManager = manager;
                  });
                },
              ),
              
              const SizedBox(height: 24),
              
              // معلومات الطوارئ
              _buildSectionHeader('معلومات الطوارئ'),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _emergencyContactController,
                decoration: const InputDecoration(
                  labelText: 'اسم جهة الاتصال في حالات الطوارئ',
                  hintText: 'اسم الشخص للاتصال به',
                  prefixIcon: Icon(Icons.person_add),
                ),
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _emergencyPhoneController,
                decoration: const InputDecoration(
                  labelText: 'رقم هاتف الطوارئ',
                  hintText: 'رقم الشخص للاتصال به',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
              
              const SizedBox(height: 32),
              
              // أزرار الحفظ والإلغاء
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isLoading ? null : () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('إلغاء'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _saveEmployee,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppTheme.primaryColor,
                      ),
                      child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(widget.employee == null ? 'إضافة موظف' : 'حفظ التغييرات'),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }
}