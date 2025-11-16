// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_rule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceRuleModelImpl _$$AttendanceRuleModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceRuleModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      workDays: (json['workDays'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      workStartTime: json['workStartTime'] as String,
      workEndTime: json['workEndTime'] as String,
      workHoursPerDay: (json['workHoursPerDay'] as num).toInt(),
      lateMinutesAllowed: (json['lateMinutesAllowed'] as num?)?.toInt() ?? 15,
      earlyDepartureMinutesAllowed:
          (json['earlyDepartureMinutesAllowed'] as num?)?.toInt() ?? 15,
      graceMinutes: (json['graceMinutes'] as num?)?.toInt() ?? 5,
      overtimeEnabled: json['overtimeEnabled'] as bool? ?? true,
      overtimeStartAfterMinutes:
          (json['overtimeStartAfterMinutes'] as num?)?.toInt() ?? 0,
      overtimeMultiplier:
          (json['overtimeMultiplier'] as num?)?.toDouble() ?? 1.5,
      breakRequired: json['breakRequired'] as bool? ?? true,
      breakDurationMinutes:
          (json['breakDurationMinutes'] as num?)?.toInt() ?? 60,
      breakPaid: json['breakPaid'] as bool? ?? false,
      departmentId: json['departmentId'] as String?,
      employeeId: json['employeeId'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$AttendanceRuleModelImplToJson(
        _$AttendanceRuleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'workDays': instance.workDays,
      'workStartTime': instance.workStartTime,
      'workEndTime': instance.workEndTime,
      'workHoursPerDay': instance.workHoursPerDay,
      'lateMinutesAllowed': instance.lateMinutesAllowed,
      'earlyDepartureMinutesAllowed': instance.earlyDepartureMinutesAllowed,
      'graceMinutes': instance.graceMinutes,
      'overtimeEnabled': instance.overtimeEnabled,
      'overtimeStartAfterMinutes': instance.overtimeStartAfterMinutes,
      'overtimeMultiplier': instance.overtimeMultiplier,
      'breakRequired': instance.breakRequired,
      'breakDurationMinutes': instance.breakDurationMinutes,
      'breakPaid': instance.breakPaid,
      'departmentId': instance.departmentId,
      'employeeId': instance.employeeId,
      'isDefault': instance.isDefault,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
