import 'dart:convert';

class Department {
  final String id;
  final String code;
  final String name;
  final String? description;
  final String? managerId;
  final String? parentDepartmentId;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // العلاقات
  Employee? manager;
  Department? parentDepartment;
  List<Department>? subDepartments;
  List<Employee>? employees;
  
  Department({
    required this.id,
    required this.code,
    required this.name,
    this.description,
    this.managerId,
    this.parentDepartmentId,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });
  
  // إنشاء من Map
  factory Department.fromMap(Map<String, dynamic> map) {
    return Department(
      id: map['id'].toString(),
      code: map['code'],
      name: map['name'],
      description: map['description'],
      managerId: map['manager_id']?.toString(),
      parentDepartmentId: map['parent_department_id']?.toString(),
      isActive: map['is_active'] == 1,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }
  
  // التحويل إلى Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'description': description,
      'manager_id': managerId,
      'parent_department_id': parentDepartmentId,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
  
  // إنشاء نسخة جديدة مع تعديلات
  Department copyWith({
    String? id,
    String? code,
    String? name,
    String? description,
    String? managerId,
    String? parentDepartmentId,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Department(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      managerId: managerId ?? this.managerId,
      parentDepartmentId: parentDepartmentId ?? this.parentDepartmentId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  // الحصول على عدد الموظفين
  int get employeeCount => employees?.length ?? 0;
  
  // الحصول على عدد الأقسام الفرعية
  int get subDepartmentCount => subDepartments?.length ?? 0;
  
  // التحقق من أن القسم نشط
  bool get isDepartmentActive => isActive;
  
  // الحصول على المسار الكامل للقسم
  String get fullPath {
    if (parentDepartment == null) {
      return name;
    }
    return '${parentDepartment!.fullPath} / $name';
  }
  
  // الحصول على معلومات القسم
  Map<String, dynamic> get departmentInfo {
    return {
      'id': id,
      'code': code,
      'name': name,
      'description': description,
      'manager': manager?.fullName,
      'employeeCount': employeeCount,
      'isActive': isActive,
    };
  }
  
  @override
  String toString() {
    return 'Department(id: $id, code: $code, name: $name)';
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Department && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
}

class JobTitle {
  final String id;
  final String code;
  final String title;
  final String? description;
  final String? departmentId;
  final int? level;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // العلاقات
  Department? department;
  
  JobTitle({
    required this.id,
    required this.code,
    required this.title,
    this.description,
    this.departmentId,
    this.level,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });
  
  // إنشاء من Map
  factory JobTitle.fromMap(Map<String, dynamic> map) {
    return JobTitle(
      id: map['id'].toString(),
      code: map['code'],
      title: map['title'],
      description: map['description'],
      departmentId: map['department_id']?.toString(),
      level: map['level'],
      isActive: map['is_active'] == 1,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }
  
  // التحويل إلى Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'title': title,
      'description': description,
      'department_id': departmentId,
      'level': level,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
  
  // إنشاء نسخة جديدة مع تعديلات
  JobTitle copyWith({
    String? id,
    String? code,
    String? title,
    String? description,
    String? departmentId,
    int? level,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return JobTitle(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      description: description ?? this.description,
      departmentId: departmentId ?? this.departmentId,
      level: level ?? this.level,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  // التحقق من أن المسمى الوظيفي نشط
  bool get isTitleActive => isActive;
  
  // الحصول على معلومات المسمى الوظيفي
  Map<String, dynamic> get jobTitleInfo {
    return {
      'id': id,
      'code': code,
      'title': title,
      'description': description,
      'department': department?.name,
      'level': level,
      'isActive': isActive,
    };
  }
  
  @override
  String toString() {
    return 'JobTitle(id: $id, code: $code, title: $title)';
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is JobTitle && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
}