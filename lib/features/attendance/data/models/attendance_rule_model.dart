import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/attendance_rule.dart';

part 'attendance_rule_model.freezed.dart';
part 'attendance_rule_model.g.dart';

/// AttendanceRule data model with JSON serialization
@freezed
class AttendanceRuleModel with _$AttendanceRuleModel {
  const AttendanceRuleModel._();

  const factory AttendanceRuleModel({
    required String id,
    required String name,
    String? description,
    required List<int> workDays,
    required String workStartTime,
    required String workEndTime,
    required int workHoursPerDay,
    @Default(15) int lateMinutesAllowed,
    @Default(15) int earlyDepartureMinutesAllowed,
    @Default(5) int graceMinutes,
    @Default(true) bool overtimeEnabled,
    @Default(0) int overtimeStartAfterMinutes,
    @Default(1.5) double overtimeMultiplier,
    @Default(true) bool breakRequired,
    @Default(60) int breakDurationMinutes,
    @Default(false) bool breakPaid,
    String? departmentId,
    String? employeeId,
    @Default(false) bool isDefault,
    @Default(true) bool isActive,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _AttendanceRuleModel;

  /// Create from JSON
  factory AttendanceRuleModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRuleModelFromJson(json);

  /// Create from domain entity
  factory AttendanceRuleModel.fromEntity(AttendanceRule entity) {
    return AttendanceRuleModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      workDays: entity.workDays,
      workStartTime: entity.workStartTime,
      workEndTime: entity.workEndTime,
      workHoursPerDay: entity.workHoursPerDay,
      lateMinutesAllowed: entity.lateMinutesAllowed,
      earlyDepartureMinutesAllowed: entity.earlyDepartureMinutesAllowed,
      graceMinutes: entity.graceMinutes,
      overtimeEnabled: entity.overtimeEnabled,
      overtimeStartAfterMinutes: entity.overtimeStartAfterMinutes,
      overtimeMultiplier: entity.overtimeMultiplier,
      breakRequired: entity.breakRequired,
      breakDurationMinutes: entity.breakDurationMinutes,
      breakPaid: entity.breakPaid,
      departmentId: entity.departmentId,
      employeeId: entity.employeeId,
      isDefault: entity.isDefault,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Convert to domain entity
  AttendanceRule toEntity() {
    return AttendanceRule(
      id: id,
      name: name,
      description: description,
      workDays: workDays,
      workStartTime: workStartTime,
      workEndTime: workEndTime,
      workHoursPerDay: workHoursPerDay,
      lateMinutesAllowed: lateMinutesAllowed,
      earlyDepartureMinutesAllowed: earlyDepartureMinutesAllowed,
      graceMinutes: graceMinutes,
      overtimeEnabled: overtimeEnabled,
      overtimeStartAfterMinutes: overtimeStartAfterMinutes,
      overtimeMultiplier: overtimeMultiplier,
      breakRequired: breakRequired,
      breakDurationMinutes: breakDurationMinutes,
      breakPaid: breakPaid,
      departmentId: departmentId,
      employeeId: employeeId,
      isDefault: isDefault,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from database map
  factory AttendanceRuleModel.fromDatabase(Map<String, dynamic> map) {
    // Parse work days from comma-separated string
    final workDaysString = map['work_days'] as String;
    final workDays = workDaysString
        .split(',')
        .map((e) => int.parse(e.trim()))
        .toList();

    return AttendanceRuleModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      workDays: workDays,
      workStartTime: map['work_start_time'] as String,
      workEndTime: map['work_end_time'] as String,
      workHoursPerDay: map['work_hours_per_day'] as int,
      lateMinutesAllowed: map['late_minutes_allowed'] as int? ?? 15,
      earlyDepartureMinutesAllowed:
          map['early_departure_minutes_allowed'] as int? ?? 15,
      graceMinutes: map['grace_minutes'] as int? ?? 5,
      overtimeEnabled: (map['overtime_enabled'] as int?) == 1,
      overtimeStartAfterMinutes: map['overtime_start_after_minutes'] as int? ?? 0,
      overtimeMultiplier: (map['overtime_multiplier'] as num?)?.toDouble() ?? 1.5,
      breakRequired: (map['break_required'] as int?) == 1,
      breakDurationMinutes: map['break_duration_minutes'] as int? ?? 60,
      breakPaid: (map['break_paid'] as int?) == 1,
      departmentId: map['department_id'] as String?,
      employeeId: map['employee_id'] as String?,
      isDefault: (map['is_default'] as int?) == 1,
      isActive: (map['is_active'] as int?) == 1,
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
      'name': name,
      'description': description,
      'work_days': workDays.join(','),
      'work_start_time': workStartTime,
      'work_end_time': workEndTime,
      'work_hours_per_day': workHoursPerDay,
      'late_minutes_allowed': lateMinutesAllowed,
      'early_departure_minutes_allowed': earlyDepartureMinutesAllowed,
      'grace_minutes': graceMinutes,
      'overtime_enabled': overtimeEnabled ? 1 : 0,
      'overtime_start_after_minutes': overtimeStartAfterMinutes,
      'overtime_multiplier': overtimeMultiplier,
      'break_required': breakRequired ? 1 : 0,
      'break_duration_minutes': breakDurationMinutes,
      'break_paid': breakPaid ? 1 : 0,
      'department_id': departmentId,
      'employee_id': employeeId,
      'is_default': isDefault ? 1 : 0,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

