// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_balance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveBalanceModelImpl _$$LeaveBalanceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaveBalanceModelImpl(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      employeeName: json['employeeName'] as String?,
      leaveTypeId: json['leaveTypeId'] as String,
      leaveTypeName: json['leaveTypeName'] as String?,
      year: (json['year'] as num).toInt(),
      totalDays: (json['totalDays'] as num).toInt(),
      usedDays: (json['usedDays'] as num?)?.toInt() ?? 0,
      pendingDays: (json['pendingDays'] as num?)?.toInt() ?? 0,
      remainingDays: (json['remainingDays'] as num?)?.toInt() ?? 0,
      carriedForwardDays: (json['carriedForwardDays'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$LeaveBalanceModelImplToJson(
        _$LeaveBalanceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeId': instance.employeeId,
      'employeeName': instance.employeeName,
      'leaveTypeId': instance.leaveTypeId,
      'leaveTypeName': instance.leaveTypeName,
      'year': instance.year,
      'totalDays': instance.totalDays,
      'usedDays': instance.usedDays,
      'pendingDays': instance.pendingDays,
      'remainingDays': instance.remainingDays,
      'carriedForwardDays': instance.carriedForwardDays,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
