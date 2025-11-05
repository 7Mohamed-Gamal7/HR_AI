import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/attendance.dart';

part 'attendance_model.freezed.dart';
part 'attendance_model.g.dart';

/// Attendance data model with JSON serialization
@freezed
class AttendanceModel with _$AttendanceModel {
  const AttendanceModel._();

  const factory AttendanceModel({
    required String id,
    required String employeeId,
    String? employeeName,
    required DateTime date,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    required String status,
    int? workDuration,
    int? lateDuration,
    int? earlyDepartureDuration,
    int? overtimeDuration,
    String? notes,
    String? checkInMethod,
    String? checkOutMethod,
    String? checkInLocation,
    String? checkOutLocation,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _AttendanceModel;

  /// Create from JSON
  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);

  /// Create from domain entity
  factory AttendanceModel.fromEntity(Attendance entity) {
    return AttendanceModel(
      id: entity.id,
      employeeId: entity.employeeId,
      employeeName: entity.employeeName,
      date: entity.date,
      checkInTime: entity.checkInTime,
      checkOutTime: entity.checkOutTime,
      status: entity.status,
      workDuration: entity.workDuration,
      lateDuration: entity.lateDuration,
      earlyDepartureDuration: entity.earlyDepartureDuration,
      overtimeDuration: entity.overtimeDuration,
      notes: entity.notes,
      checkInMethod: entity.checkInMethod,
      checkOutMethod: entity.checkOutMethod,
      checkInLocation: entity.checkInLocation,
      checkOutLocation: entity.checkOutLocation,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Convert to domain entity
  Attendance toEntity() {
    return Attendance(
      id: id,
      employeeId: employeeId,
      employeeName: employeeName,
      date: date,
      checkInTime: checkInTime,
      checkOutTime: checkOutTime,
      status: status,
      workDuration: workDuration,
      lateDuration: lateDuration,
      earlyDepartureDuration: earlyDepartureDuration,
      overtimeDuration: overtimeDuration,
      notes: notes,
      checkInMethod: checkInMethod,
      checkOutMethod: checkOutMethod,
      checkInLocation: checkInLocation,
      checkOutLocation: checkOutLocation,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from database map
  factory AttendanceModel.fromDatabase(Map<String, dynamic> map) {
    return AttendanceModel(
      id: map['id'] as String,
      employeeId: map['employee_id'] as String,
      employeeName: map['employee_name'] as String?,
      date: DateTime.parse(map['date'] as String),
      checkInTime: map['check_in_time'] != null
          ? DateTime.parse(map['check_in_time'] as String)
          : null,
      checkOutTime: map['check_out_time'] != null
          ? DateTime.parse(map['check_out_time'] as String)
          : null,
      status: map['status'] as String,
      workDuration: map['work_duration'] as int?,
      lateDuration: map['late_duration'] as int?,
      earlyDepartureDuration: map['early_departure_duration'] as int?,
      overtimeDuration: map['overtime_duration'] as int?,
      notes: map['notes'] as String?,
      checkInMethod: map['check_in_method'] as String?,
      checkOutMethod: map['check_out_method'] as String?,
      checkInLocation: map['check_in_location'] as String?,
      checkOutLocation: map['check_out_location'] as String?,
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
      'employee_id': employeeId,
      'date': date.toIso8601String().split('T')[0],
      'check_in_time': checkInTime?.toIso8601String(),
      'check_out_time': checkOutTime?.toIso8601String(),
      'status': status,
      'work_duration': workDuration,
      'late_duration': lateDuration,
      'early_departure_duration': earlyDepartureDuration,
      'overtime_duration': overtimeDuration,
      'notes': notes,
      'check_in_method': checkInMethod,
      'check_out_method': checkOutMethod,
      'check_in_location': checkInLocation,
      'check_out_location': checkOutLocation,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

