import 'package:equatable/equatable.dart';

/// Employee entity
class Employee extends Equatable {
  final String id;
  final String employeeCode;
  final String firstName;
  final String lastName;
  final String? middleName;
  final String fullName;
  final String email;
  final String phone;
  final String? nationalId;
  final DateTime? birthDate;
  final String gender;
  final String maritalStatus;
  final String? address;
  final String? city;
  final String? country;
  final String? profileImage;
  
  // Employment details
  final String departmentId;
  final String? departmentName;
  final String positionId;
  final String? positionTitle;
  final DateTime hireDate;
  final String employmentType;
  final String status; // active, inactive, terminated
  
  // Salary information
  final double basicSalary;
  final String? currency;
  
  // Manager information
  final String? managerId;
  final String? managerName;
  
  // Additional information
  final String? emergencyContactName;
  final String? emergencyContactPhone;
  final String? notes;
  
  // Timestamps
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Employee({
    required this.id,
    required this.employeeCode,
    required this.firstName,
    required this.lastName,
    this.middleName,
    required this.fullName,
    required this.email,
    required this.phone,
    this.nationalId,
    this.birthDate,
    required this.gender,
    required this.maritalStatus,
    this.address,
    this.city,
    this.country,
    this.profileImage,
    required this.departmentId,
    this.departmentName,
    required this.positionId,
    this.positionTitle,
    required this.hireDate,
    required this.employmentType,
    required this.status,
    required this.basicSalary,
    this.currency,
    this.managerId,
    this.managerName,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        employeeCode,
        firstName,
        lastName,
        middleName,
        fullName,
        email,
        phone,
        nationalId,
        birthDate,
        gender,
        maritalStatus,
        address,
        city,
        country,
        profileImage,
        departmentId,
        departmentName,
        positionId,
        positionTitle,
        hireDate,
        employmentType,
        status,
        basicSalary,
        currency,
        managerId,
        managerName,
        emergencyContactName,
        emergencyContactPhone,
        notes,
        createdAt,
        updatedAt,
      ];

  Employee copyWith({
    String? id,
    String? employeeCode,
    String? firstName,
    String? lastName,
    String? middleName,
    String? fullName,
    String? email,
    String? phone,
    String? nationalId,
    DateTime? birthDate,
    String? gender,
    String? maritalStatus,
    String? address,
    String? city,
    String? country,
    String? profileImage,
    String? departmentId,
    String? departmentName,
    String? positionId,
    String? positionTitle,
    DateTime? hireDate,
    String? employmentType,
    String? status,
    double? basicSalary,
    String? currency,
    String? managerId,
    String? managerName,
    String? emergencyContactName,
    String? emergencyContactPhone,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Employee(
      id: id ?? this.id,
      employeeCode: employeeCode ?? this.employeeCode,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      nationalId: nationalId ?? this.nationalId,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      profileImage: profileImage ?? this.profileImage,
      departmentId: departmentId ?? this.departmentId,
      departmentName: departmentName ?? this.departmentName,
      positionId: positionId ?? this.positionId,
      positionTitle: positionTitle ?? this.positionTitle,
      hireDate: hireDate ?? this.hireDate,
      employmentType: employmentType ?? this.employmentType,
      status: status ?? this.status,
      basicSalary: basicSalary ?? this.basicSalary,
      currency: currency ?? this.currency,
      managerId: managerId ?? this.managerId,
      managerName: managerName ?? this.managerName,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactPhone: emergencyContactPhone ?? this.emergencyContactPhone,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

