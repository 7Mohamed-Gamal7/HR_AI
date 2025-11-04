import 'dart:convert';

class Employee {
  final String id;
  final String employeeNumber;
  final String firstName;
  final String lastName;
  final String fullName;
  final String? email;
  final String? phone;
  final String? mobile;
  final DateTime? dateOfBirth;
  final String? nationality;
  final String? gender;
  final String? maritalStatus;
  final String? address;
  final String? city;
  final String? country;
  final String? postalCode;
  final String? departmentId;
  final String? jobTitleId;
  final String? managerId;
  final DateTime? hireDate;
  final double? salary;
  final String? employmentType;
  final String status;
  final String? profileImage;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // العلاقات
  Department? department;
  JobTitle? jobTitle;
  Employee? manager;
  
  Employee({
    required this.id,
    required this.employeeNumber,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    this.email,
    this.phone,
    this.mobile,
    this.dateOfBirth,
    this.nationality,
    this.gender,
    this.maritalStatus,
    this.address,
    this.city,
    this.country,
    this.postalCode,
    this.departmentId,
    this.jobTitleId,
    this.managerId,
    this.hireDate,
    this.salary,
    this.employmentType,
    this.status = 'active',
    this.profileImage,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  
  // إنشاء من Map
  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'].toString(),
      employeeNumber: map['employee_number'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      fullName: map['full_name'],
      email: map['email'],
      phone: map['phone'],
      mobile: map['mobile'],
      dateOfBirth: map['date_of_birth'] != null 
          ? DateTime.parse(map['date_of_birth']) 
          : null,
      nationality: map['nationality'],
      gender: map['gender'],
      maritalStatus: map['marital_status'],
      address: map['address'],
      city: map['city'],
      country: map['country'],
      postalCode: map['postal_code'],
      departmentId: map['department_id']?.toString(),
      jobTitleId: map['job_title_id']?.toString(),
      managerId: map['manager_id']?.toString(),
      hireDate: map['hire_date'] != null 
          ? DateTime.parse(map['hire_date']) 
          : null,
      salary: map['salary']?.toDouble(),
      employmentType: map['employment_type'],
      status: map['status'] ?? 'active',
      profileImage: map['profile_image'],
      notes: map['notes'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }
  
  // التحويل إلى Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employee_number': employeeNumber,
      'first_name': firstName,
      'last_name': lastName,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'mobile': mobile,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'nationality': nationality,
      'gender': gender,
      'marital_status': maritalStatus,
      'address': address,
      'city': city,
      'country': country,
      'postal_code': postalCode,
      'department_id': departmentId,
      'job_title_id': jobTitleId,
      'manager_id': managerId,
      'hire_date': hireDate?.toIso8601String(),
      'salary': salary,
      'employment_type': employmentType,
      'status': status,
      'profile_image': profileImage,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
  
  // إنشاء نسخة جديدة مع تعديلات
  Employee copyWith({
    String? id,
    String? employeeNumber,
    String? firstName,
    String? lastName,
    String? fullName,
    String? email,
    String? phone,
    String? mobile,
    DateTime? dateOfBirth,
    String? nationality,
    String? gender,
    String? maritalStatus,
    String? address,
    String? city,
    String? country,
    String? postalCode,
    String? departmentId,
    String? jobTitleId,
    String? managerId,
    DateTime? hireDate,
    double? salary,
    String? employmentType,
    String? status,
    String? profileImage,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Employee(
      id: id ?? this.id,
      employeeNumber: employeeNumber ?? this.employeeNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      mobile: mobile ?? this.mobile,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      nationality: nationality ?? this.nationality,
      gender: gender ?? this.gender,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      departmentId: departmentId ?? this.departmentId,
      jobTitleId: jobTitleId ?? this.jobTitleId,
      managerId: managerId ?? this.managerId,
      hireDate: hireDate ?? this.hireDate,
      salary: salary ?? this.salary,
      employmentType: employmentType ?? this.employmentType,
      status: status ?? this.status,
      profileImage: profileImage ?? this.profileImage,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  // الحصول على العمر
  int? get age {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month || 
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }
  
  // الحصول على مدة الخدمة
  String? get serviceDuration {
    if (hireDate == null) return null;
    final now = DateTime.now();
    final difference = now.difference(hireDate!);
    
    final years = difference.inDays ~/ 365;
    final months = (difference.inDays % 365) ~/ 30;
    final days = (difference.inDays % 365) % 30;
    
    if (years > 0) {
      return '$years سنة و $months شهر';
    } else if (months > 0) {
      return '$months شهر و $days يوم';
    } else {
      return '$days يوم';
    }
  }
  
  // الحصول على الحالة النصية
  String get statusText {
    switch (status) {
      case 'active':
        return 'نشط';
      case 'inactive':
        return 'غير نشط';
      case 'suspended':
        return 'موقوف';
      case 'terminated':
        return 'منتهي الخدمة';
      default:
        return 'غير معروف';
    }
  }
  
  // الحصول على لون الحالة
  Color get statusColor {
    switch (status) {
      case 'active':
        return Colors.green;
      case 'inactive':
        return Colors.grey;
      case 'suspended':
        return Colors.orange;
      case 'terminated':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
  
  // التحقق من أن الموظف نشط
  bool get isActive => status == 'active';
  
  // الحصول على الاسم الكامل مع اللقب
  String get displayName {
    if (jobTitle != null) {
      return '${jobTitle!.title} $fullName';
    }
    return fullName;
  }
  
  // الحصول على المعلومات الأساسية
  Map<String, dynamic> get basicInfo {
    return {
      'id': id,
      'employeeNumber': employeeNumber,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'department': department?.name,
      'jobTitle': jobTitle?.title,
      'status': status,
    };
  }
  
  @override
  String toString() {
    return 'Employee(id: $id, name: $fullName, employeeNumber: $employeeNumber)';
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Employee && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
}