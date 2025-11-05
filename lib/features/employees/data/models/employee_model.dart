import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/employee.dart';

part 'employee_model.freezed.dart';
part 'employee_model.g.dart';

/// Employee data model with JSON serialization
@freezed
class EmployeeModel with _$EmployeeModel {
  const EmployeeModel._();

  const factory EmployeeModel({
    required String id,
    required String employeeCode,
    required String firstName,
    required String lastName,
    String? middleName,
    required String fullName,
    required String email,
    required String phone,
    String? nationalId,
    DateTime? birthDate,
    required String gender,
    required String maritalStatus,
    String? address,
    String? city,
    String? country,
    String? profileImage,
    required String departmentId,
    String? departmentName,
    required String positionId,
    String? positionTitle,
    required DateTime hireDate,
    required String employmentType,
    @Default('active') String status,
    required double basicSalary,
    @Default('EGP') String currency,
    String? managerId,
    String? managerName,
    String? emergencyContactName,
    String? emergencyContactPhone,
    String? notes,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _EmployeeModel;

  /// Create from JSON
  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  /// Create from domain entity
  factory EmployeeModel.fromEntity(Employee entity) {
    return EmployeeModel(
      id: entity.id,
      employeeCode: entity.employeeCode,
      firstName: entity.firstName,
      lastName: entity.lastName,
      middleName: entity.middleName,
      fullName: entity.fullName,
      email: entity.email,
      phone: entity.phone,
      nationalId: entity.nationalId,
      birthDate: entity.birthDate,
      gender: entity.gender,
      maritalStatus: entity.maritalStatus,
      address: entity.address,
      city: entity.city,
      country: entity.country,
      profileImage: entity.profileImage,
      departmentId: entity.departmentId,
      departmentName: entity.departmentName,
      positionId: entity.positionId,
      positionTitle: entity.positionTitle,
      hireDate: entity.hireDate,
      employmentType: entity.employmentType,
      status: entity.status,
      basicSalary: entity.basicSalary,
      currency: entity.currency,
      managerId: entity.managerId,
      managerName: entity.managerName,
      emergencyContactName: entity.emergencyContactName,
      emergencyContactPhone: entity.emergencyContactPhone,
      notes: entity.notes,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Convert to domain entity
  Employee toEntity() {
    return Employee(
      id: id,
      employeeCode: employeeCode,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      fullName: fullName,
      email: email,
      phone: phone,
      nationalId: nationalId,
      birthDate: birthDate,
      gender: gender,
      maritalStatus: maritalStatus,
      address: address,
      city: city,
      country: country,
      profileImage: profileImage,
      departmentId: departmentId,
      departmentName: departmentName,
      positionId: positionId,
      positionTitle: positionTitle,
      hireDate: hireDate,
      employmentType: employmentType,
      status: status,
      basicSalary: basicSalary,
      currency: currency,
      managerId: managerId,
      managerName: managerName,
      emergencyContactName: emergencyContactName,
      emergencyContactPhone: emergencyContactPhone,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from database map
  factory EmployeeModel.fromDatabase(Map<String, dynamic> map) {
    return EmployeeModel(
      id: map['id'] as String,
      employeeCode: map['employee_code'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      middleName: map['middle_name'] as String?,
      fullName: map['full_name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      nationalId: map['national_id'] as String?,
      birthDate: map['birth_date'] != null
          ? DateTime.parse(map['birth_date'] as String)
          : null,
      gender: map['gender'] as String,
      maritalStatus: map['marital_status'] as String,
      address: map['address'] as String?,
      city: map['city'] as String?,
      country: map['country'] as String?,
      profileImage: map['profile_image'] as String?,
      departmentId: map['department_id'] as String,
      departmentName: map['department_name'] as String?,
      positionId: map['position_id'] as String,
      positionTitle: map['position_title'] as String?,
      hireDate: DateTime.parse(map['hire_date'] as String),
      employmentType: map['employment_type'] as String,
      status: map['status'] as String? ?? 'active',
      basicSalary: (map['basic_salary'] as num).toDouble(),
      currency: map['currency'] as String? ?? 'EGP',
      managerId: map['manager_id'] as String?,
      managerName: map['manager_name'] as String?,
      emergencyContactName: map['emergency_contact_name'] as String?,
      emergencyContactPhone: map['emergency_contact_phone'] as String?,
      notes: map['notes'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }

  /// Convert to database map
  Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'employee_code': employeeCode,
      'first_name': firstName,
      'last_name': lastName,
      'middle_name': middleName,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'national_id': nationalId,
      'birth_date': birthDate?.toIso8601String().split('T')[0],
      'gender': gender,
      'marital_status': maritalStatus,
      'address': address,
      'city': city,
      'country': country,
      'profile_image': profileImage,
      'department_id': departmentId,
      'position_id': positionId,
      'hire_date': hireDate.toIso8601String().split('T')[0],
      'employment_type': employmentType,
      'status': status,
      'basic_salary': basicSalary,
      'currency': currency,
      'manager_id': managerId,
      'emergency_contact_name': emergencyContactName,
      'emergency_contact_phone': emergencyContactPhone,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

