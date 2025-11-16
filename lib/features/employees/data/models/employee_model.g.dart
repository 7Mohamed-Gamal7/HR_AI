// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeModelImpl _$$EmployeeModelImplFromJson(Map<String, dynamic> json) =>
    _$EmployeeModelImpl(
      id: json['id'] as String,
      employeeCode: json['employeeCode'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      middleName: json['middleName'] as String?,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      nationalId: json['nationalId'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      gender: json['gender'] as String,
      maritalStatus: json['maritalStatus'] as String,
      address: json['address'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      profileImage: json['profileImage'] as String?,
      departmentId: json['departmentId'] as String,
      departmentName: json['departmentName'] as String?,
      positionId: json['positionId'] as String,
      positionTitle: json['positionTitle'] as String?,
      hireDate: DateTime.parse(json['hireDate'] as String),
      employmentType: json['employmentType'] as String,
      status: json['status'] as String? ?? 'active',
      basicSalary: (json['basicSalary'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'EGP',
      managerId: json['managerId'] as String?,
      managerName: json['managerName'] as String?,
      emergencyContactName: json['emergencyContactName'] as String?,
      emergencyContactPhone: json['emergencyContactPhone'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$EmployeeModelImplToJson(_$EmployeeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeCode': instance.employeeCode,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'middleName': instance.middleName,
      'fullName': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'nationalId': instance.nationalId,
      'birthDate': instance.birthDate?.toIso8601String(),
      'gender': instance.gender,
      'maritalStatus': instance.maritalStatus,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
      'profileImage': instance.profileImage,
      'departmentId': instance.departmentId,
      'departmentName': instance.departmentName,
      'positionId': instance.positionId,
      'positionTitle': instance.positionTitle,
      'hireDate': instance.hireDate.toIso8601String(),
      'employmentType': instance.employmentType,
      'status': instance.status,
      'basicSalary': instance.basicSalary,
      'currency': instance.currency,
      'managerId': instance.managerId,
      'managerName': instance.managerName,
      'emergencyContactName': instance.emergencyContactName,
      'emergencyContactPhone': instance.emergencyContactPhone,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
