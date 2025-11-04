import 'package:flutter/material.dart';

enum AttendanceType {
  checkIn,
  checkOut,
  breakStart,
  breakEnd,
  overtimeStart,
  overtimeEnd,
}

enum AttendanceStatus {
  present,
  absent,
  late,
  earlyLeave,
  overtime,
  weekend,
  holiday,
  leave,
}

class AttendanceRecord {
  final int? id;
  final int employeeId;
  final DateTime date;
  final TimeOfDay? checkInTime;
  final TimeOfDay? checkOutTime;
  final TimeOfDay? breakStartTime;
  final TimeOfDay? breakEndTime;
  final TimeOfDay? overtimeStartTime;
  final TimeOfDay? overtimeEndTime;
  final Duration? totalHours;
  final Duration? overtimeHours;
  final Duration? breakDuration;
  final bool isLate;
  final bool isEarlyLeave;
  final AttendanceStatus status;
  final String? notes;
  final String? deviceId;
  final String? location;
  final double? latitude;
  final double? longitude;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AttendanceRecord({
    this.id,
    required this.employeeId,
    required this.date,
    this.checkInTime,
    this.checkOutTime,
    this.breakStartTime,
    this.breakEndTime,
    this.overtimeStartTime,
    this.overtimeEndTime,
    this.totalHours,
    this.overtimeHours,
    this.breakDuration,
    this.isLate = false,
    this.isEarlyLeave = false,
    required this.status,
    this.notes,
    this.deviceId,
    this.location,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  factory AttendanceRecord.fromMap(Map<String, dynamic> map) {
    return AttendanceRecord(
      id: map['id'],
      employeeId: map['employee_id'],
      date: DateTime.parse(map['date']),
      checkInTime: map['check_in_time'] != null ? _parseTimeOfDay(map['check_in_time']) : null,
      checkOutTime: map['check_out_time'] != null ? _parseTimeOfDay(map['check_out_time']) : null,
      breakStartTime: map['break_start_time'] != null ? _parseTimeOfDay(map['break_start_time']) : null,
      breakEndTime: map['break_end_time'] != null ? _parseTimeOfDay(map['break_end_time']) : null,
      overtimeStartTime: map['overtime_start_time'] != null ? _parseTimeOfDay(map['overtime_start_time']) : null,
      overtimeEndTime: map['overtime_end_time'] != null ? _parseTimeOfDay(map['overtime_end_time']) : null,
      totalHours: map['total_hours'] != null ? Duration(minutes: map['total_hours']) : null,
      overtimeHours: map['overtime_hours'] != null ? Duration(minutes: map['overtime_hours']) : null,
      breakDuration: map['break_duration'] != null ? Duration(minutes: map['break_duration']) : null,
      isLate: map['is_late'] == 1,
      isEarlyLeave: map['is_early_leave'] == 1,
      status: AttendanceStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => AttendanceStatus.present,
      ),
      notes: map['notes'],
      deviceId: map['device_id'],
      location: map['location'],
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employee_id': employeeId,
      'date': date.toIso8601String().split('T')[0],
      'check_in_time': checkInTime != null ? '${checkInTime!.hour.toString().padLeft(2, '0')}:${checkInTime!.minute.toString().padLeft(2, '0')}' : null,
      'check_out_time': checkOutTime != null ? '${checkOutTime!.hour.toString().padLeft(2, '0')}:${checkOutTime!.minute.toString().padLeft(2, '0')}' : null,
      'break_start_time': breakStartTime != null ? '${breakStartTime!.hour.toString().padLeft(2, '0')}:${breakStartTime!.minute.toString().padLeft(2, '0')}' : null,
      'break_end_time': breakEndTime != null ? '${breakEndTime!.hour.toString().padLeft(2, '0')}:${breakEndTime!.minute.toString().padLeft(2, '0')}' : null,
      'overtime_start_time': overtimeStartTime != null ? '${overtimeStartTime!.hour.toString().padLeft(2, '0')}:${overtimeStartTime!.minute.toString().padLeft(2, '0')}' : null,
      'overtime_end_time': overtimeEndTime != null ? '${overtimeEndTime!.hour.toString().padLeft(2, '0')}:${overtimeEndTime!.minute.toString().padLeft(2, '0')}' : null,
      'total_hours': totalHours?.inMinutes,
      'overtime_hours': overtimeHours?.inMinutes,
      'break_duration': breakDuration?.inMinutes,
      'is_late': isLate ? 1 : 0,
      'is_early_leave': isEarlyLeave ? 1 : 0,
      'status': status.name,
      'notes': notes,
      'device_id': deviceId,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  AttendanceRecord copyWith({
    int? id,
    int? employeeId,
    DateTime? date,
    TimeOfDay? checkInTime,
    TimeOfDay? checkOutTime,
    TimeOfDay? breakStartTime,
    TimeOfDay? breakEndTime,
    TimeOfDay? overtimeStartTime,
    TimeOfDay? overtimeEndTime,
    Duration? totalHours,
    Duration? overtimeHours,
    Duration? breakDuration,
    bool? isLate,
    bool? isEarlyLeave,
    AttendanceStatus? status,
    String? notes,
    String? deviceId,
    String? location,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AttendanceRecord(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      date: date ?? this.date,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      breakStartTime: breakStartTime ?? this.breakStartTime,
      breakEndTime: breakEndTime ?? this.breakEndTime,
      overtimeStartTime: overtimeStartTime ?? this.overtimeStartTime,
      overtimeEndTime: overtimeEndTime ?? this.overtimeEndTime,
      totalHours: totalHours ?? this.totalHours,
      overtimeHours: overtimeHours ?? this.overtimeHours,
      breakDuration: breakDuration ?? this.breakDuration,
      isLate: isLate ?? this.isLate,
      isEarlyLeave: isEarlyLeave ?? this.isEarlyLeave,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      deviceId: deviceId ?? this.deviceId,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get statusText {
    switch (status) {
      case AttendanceStatus.present:
        return 'حاضر';
      case AttendanceStatus.absent:
        return 'غائب';
      case AttendanceStatus.late:
        return 'متأخر';
      case AttendanceStatus.earlyLeave:
        return 'مغادر مبكراً';
      case AttendanceStatus.overtime:
        return 'عمل إضافي';
      case AttendanceStatus.weekend:
        return 'عطلة نهاية الأسبوع';
      case AttendanceStatus.holiday:
        return 'عطلة رسمية';
      case AttendanceStatus.leave:
        return 'في إجازة';
    }
  }

  Color get statusColor {
    switch (status) {
      case AttendanceStatus.present:
        return Colors.green;
      case AttendanceStatus.absent:
        return Colors.red;
      case AttendanceStatus.late:
        return Colors.orange;
      case AttendanceStatus.earlyLeave:
        return Colors.amber;
      case AttendanceStatus.overtime:
        return Colors.blue;
      case AttendanceStatus.weekend:
      case AttendanceStatus.holiday:
        return Colors.purple;
      case AttendanceStatus.leave:
        return Colors.teal;
    }
  }

  String get totalHoursFormatted {
    if (totalHours == null) return '-';
    final hours = totalHours!.inHours;
    final minutes = totalHours!.inMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  String get overtimeHoursFormatted {
    if (overtimeHours == null) return '-';
    final hours = overtimeHours!.inHours;
    final minutes = overtimeHours!.inMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  bool get hasCheckedIn => checkInTime != null;
  bool get hasCheckedOut => checkOutTime != null;
  bool get isComplete => hasCheckedIn && hasCheckedOut;

  static TimeOfDay _parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  @override
  String toString() {
    return 'AttendanceRecord(id: $id, employeeId: $employeeId, date: $date, status: $status)';
  }
}

class AttendanceRule {
  final int? id;
  final String name;
  final TimeOfDay checkInTime;
  final TimeOfDay checkOutTime;
  final Duration? breakDuration;
  final Duration lateThreshold;
  final Duration earlyLeaveThreshold;
  final bool isFlexible;
  final bool allowOvertime;
  final List<int> workingDays; // 0=Sunday, 1=Monday, ..., 6=Saturday
  final DateTime? effectiveFrom;
  final DateTime? effectiveTo;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AttendanceRule({
    this.id,
    required this.name,
    required this.checkInTime,
    required this.checkOutTime,
    this.breakDuration,
    required this.lateThreshold,
    required this.earlyLeaveThreshold,
    this.isFlexible = false,
    this.allowOvertime = true,
    required this.workingDays,
    this.effectiveFrom,
    this.effectiveTo,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory AttendanceRule.fromMap(Map<String, dynamic> map) {
    return AttendanceRule(
      id: map['id'],
      name: map['name'],
      checkInTime: AttendanceRecord._parseTimeOfDay(map['check_in_time']),
      checkOutTime: AttendanceRecord._parseTimeOfDay(map['check_out_time']),
      breakDuration: map['break_duration'] != null ? Duration(minutes: map['break_duration']) : null,
      lateThreshold: Duration(minutes: map['late_threshold']),
      earlyLeaveThreshold: Duration(minutes: map['early_leave_threshold']),
      isFlexible: map['is_flexible'] == 1,
      allowOvertime: map['allow_overtime'] == 1,
      workingDays: List<int>.from(map['working_days'].split(',').map((e) => int.parse(e))),
      effectiveFrom: map['effective_from'] != null ? DateTime.parse(map['effective_from']) : null,
      effectiveTo: map['effective_to'] != null ? DateTime.parse(map['effective_to']) : null,
      isActive: map['is_active'] == 1,
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'check_in_time': '${checkInTime.hour.toString().padLeft(2, '0')}:${checkInTime.minute.toString().padLeft(2, '0')}',
      'check_out_time': '${checkOutTime.hour.toString().padLeft(2, '0')}:${checkOutTime.minute.toString().padLeft(2, '0')}',
      'break_duration': breakDuration?.inMinutes,
      'late_threshold': lateThreshold.inMinutes,
      'early_leave_threshold': earlyLeaveThreshold.inMinutes,
      'is_flexible': isFlexible ? 1 : 0,
      'allow_overtime': allowOvertime ? 1 : 0,
      'working_days': workingDays.join(','),
      'effective_from': effectiveFrom?.toIso8601String(),
      'effective_to': effectiveTo?.toIso8601String(),
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  bool isWorkingDay(DateTime date) {
    return workingDays.contains(date.weekday % 7); // Convert to 0-6 format
  }

  bool isEffectiveOn(DateTime date) {
    if (effectiveFrom != null && date.isBefore(effectiveFrom!)) return false;
    if (effectiveTo != null && date.isAfter(effectiveTo!)) return false;
    return isActive;
  }
}