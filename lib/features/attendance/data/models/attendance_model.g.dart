// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceModelImpl _$$AttendanceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceModelImpl(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      employeeName: json['employeeName'] as String?,
      date: DateTime.parse(json['date'] as String),
      checkInTime: json['checkInTime'] == null
          ? null
          : DateTime.parse(json['checkInTime'] as String),
      checkOutTime: json['checkOutTime'] == null
          ? null
          : DateTime.parse(json['checkOutTime'] as String),
      status: json['status'] as String,
      workDuration: (json['workDuration'] as num?)?.toInt(),
      lateDuration: (json['lateDuration'] as num?)?.toInt(),
      earlyDepartureDuration: (json['earlyDepartureDuration'] as num?)?.toInt(),
      overtimeDuration: (json['overtimeDuration'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      checkInMethod: json['checkInMethod'] as String?,
      checkOutMethod: json['checkOutMethod'] as String?,
      checkInLocation: json['checkInLocation'] as String?,
      checkOutLocation: json['checkOutLocation'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$AttendanceModelImplToJson(
        _$AttendanceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeId': instance.employeeId,
      'employeeName': instance.employeeName,
      'date': instance.date.toIso8601String(),
      'checkInTime': instance.checkInTime?.toIso8601String(),
      'checkOutTime': instance.checkOutTime?.toIso8601String(),
      'status': instance.status,
      'workDuration': instance.workDuration,
      'lateDuration': instance.lateDuration,
      'earlyDepartureDuration': instance.earlyDepartureDuration,
      'overtimeDuration': instance.overtimeDuration,
      'notes': instance.notes,
      'checkInMethod': instance.checkInMethod,
      'checkOutMethod': instance.checkOutMethod,
      'checkInLocation': instance.checkInLocation,
      'checkOutLocation': instance.checkOutLocation,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
