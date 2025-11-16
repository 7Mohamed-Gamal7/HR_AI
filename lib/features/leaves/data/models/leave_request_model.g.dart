// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveRequestModelImpl _$$LeaveRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaveRequestModelImpl(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      employeeName: json['employeeName'] as String?,
      leaveTypeId: json['leaveTypeId'] as String,
      leaveTypeName: json['leaveTypeName'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      numberOfDays: (json['numberOfDays'] as num).toInt(),
      status: json['status'] as String,
      reason: json['reason'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
      approverId: json['approverId'] as String?,
      approverName: json['approverName'] as String?,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      documentPath: json['documentPath'] as String?,
      isEmergency: json['isEmergency'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$LeaveRequestModelImplToJson(
        _$LeaveRequestModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeId': instance.employeeId,
      'employeeName': instance.employeeName,
      'leaveTypeId': instance.leaveTypeId,
      'leaveTypeName': instance.leaveTypeName,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'numberOfDays': instance.numberOfDays,
      'status': instance.status,
      'reason': instance.reason,
      'rejectionReason': instance.rejectionReason,
      'approverId': instance.approverId,
      'approverName': instance.approverName,
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'documentPath': instance.documentPath,
      'isEmergency': instance.isEmergency,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
