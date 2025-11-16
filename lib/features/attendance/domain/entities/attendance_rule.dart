import 'package:equatable/equatable.dart';

/// Attendance rule entity
class AttendanceRule extends Equatable {
  final String id;
  final String name;
  final String? description;
  
  // Work schedule
  final List<int> workDays; // 1-7 (Monday-Sunday)
  final DateTime workStartTime;
  final DateTime workEndTime;
  final int workHoursPerDay;
  
  // Flexibility settings
  final int lateMinutesAllowed;
  final int earlyDepartureMinutesAllowed;
  final int graceMinutes; // Grace period before marking as late
  
  // Overtime settings
  final bool overtimeEnabled;
  final int overtimeStartAfterMinutes;
  final double overtimeMultiplier; // e.g., 1.5 for 1.5x pay
  
  // Break settings
  final bool breakRequired;
  final int breakDurationMinutes;
  final bool breakPaid;
  
  // Application scope
  final String? departmentId;
  final String? employeeId;
  final bool isDefault;
  final bool isActive;
  
  final DateTime createdAt;
  final DateTime? updatedAt;

  const AttendanceRule({
    required this.id,
    required this.name,
    this.description,
    required this.workDays,
    required this.workStartTime,
    required this.workEndTime,
    required this.workHoursPerDay,
    this.lateMinutesAllowed = 15,
    this.earlyDepartureMinutesAllowed = 15,
    this.graceMinutes = 5,
    this.overtimeEnabled = true,
    this.overtimeStartAfterMinutes = 0,
    this.overtimeMultiplier = 1.5,
    this.breakRequired = true,
    this.breakDurationMinutes = 60,
    this.breakPaid = false,
    this.departmentId,
    this.employeeId,
    this.isDefault = false,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        workDays,
        workStartTime,
        workEndTime,
        workHoursPerDay,
        lateMinutesAllowed,
        earlyDepartureMinutesAllowed,
        graceMinutes,
        overtimeEnabled,
        overtimeStartAfterMinutes,
        overtimeMultiplier,
        breakRequired,
        breakDurationMinutes,
        breakPaid,
        departmentId,
        employeeId,
        isDefault,
        isActive,
        createdAt,
        updatedAt,
      ];

  AttendanceRule copyWith({
    String? id,
    String? name,
    String? description,
    List<int>? workDays,
    DateTime? workStartTime,
    DateTime? workEndTime,
    int? workHoursPerDay,
    int? lateMinutesAllowed,
    int? earlyDepartureMinutesAllowed,
    int? graceMinutes,
    bool? overtimeEnabled,
    int? overtimeStartAfterMinutes,
    double? overtimeMultiplier,
    bool? breakRequired,
    int? breakDurationMinutes,
    bool? breakPaid,
    String? departmentId,
    String? employeeId,
    bool? isDefault,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AttendanceRule(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      workDays: workDays ?? this.workDays,
      workStartTime: workStartTime ?? this.workStartTime,
      workEndTime: workEndTime ?? this.workEndTime,
      workHoursPerDay: workHoursPerDay ?? this.workHoursPerDay,
      lateMinutesAllowed: lateMinutesAllowed ?? this.lateMinutesAllowed,
      earlyDepartureMinutesAllowed: earlyDepartureMinutesAllowed ?? this.earlyDepartureMinutesAllowed,
      graceMinutes: graceMinutes ?? this.graceMinutes,
      overtimeEnabled: overtimeEnabled ?? this.overtimeEnabled,
      overtimeStartAfterMinutes: overtimeStartAfterMinutes ?? this.overtimeStartAfterMinutes,
      overtimeMultiplier: overtimeMultiplier ?? this.overtimeMultiplier,
      breakRequired: breakRequired ?? this.breakRequired,
      breakDurationMinutes: breakDurationMinutes ?? this.breakDurationMinutes,
      breakPaid: breakPaid ?? this.breakPaid,
      departmentId: departmentId ?? this.departmentId,
      employeeId: employeeId ?? this.employeeId,
      isDefault: isDefault ?? this.isDefault,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

