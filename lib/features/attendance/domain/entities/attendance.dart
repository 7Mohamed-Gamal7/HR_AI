import 'package:equatable/equatable.dart';

/// Attendance entity
class Attendance extends Equatable {
  final String id;
  final String employeeId;
  final String? employeeName;
  final DateTime date;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final String status; // present, absent, late, early_departure, on_leave, holiday, weekend
  final Duration? workDuration;
  final Duration? lateDuration;
  final Duration? earlyDepartureDuration;
  final Duration? overtimeDuration;
  final String? notes;
  final String? checkInMethod; // manual, biometric, qr_code
  final String? checkOutMethod;
  final String? checkInLocation;
  final String? checkOutLocation;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Attendance({
    required this.id,
    required this.employeeId,
    this.employeeName,
    required this.date,
    this.checkInTime,
    this.checkOutTime,
    required this.status,
    this.workDuration,
    this.lateDuration,
    this.earlyDepartureDuration,
    this.overtimeDuration,
    this.notes,
    this.checkInMethod,
    this.checkOutMethod,
    this.checkInLocation,
    this.checkOutLocation,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        employeeId,
        employeeName,
        date,
        checkInTime,
        checkOutTime,
        status,
        workDuration,
        lateDuration,
        earlyDepartureDuration,
        overtimeDuration,
        notes,
        checkInMethod,
        checkOutMethod,
        checkInLocation,
        checkOutLocation,
        createdAt,
        updatedAt,
      ];

  Attendance copyWith({
    String? id,
    String? employeeId,
    String? employeeName,
    DateTime? date,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    String? status,
    Duration? workDuration,
    Duration? lateDuration,
    Duration? earlyDepartureDuration,
    Duration? overtimeDuration,
    String? notes,
    String? checkInMethod,
    String? checkOutMethod,
    String? checkInLocation,
    String? checkOutLocation,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Attendance(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      date: date ?? this.date,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      status: status ?? this.status,
      workDuration: workDuration ?? this.workDuration,
      lateDuration: lateDuration ?? this.lateDuration,
      earlyDepartureDuration: earlyDepartureDuration ?? this.earlyDepartureDuration,
      overtimeDuration: overtimeDuration ?? this.overtimeDuration,
      notes: notes ?? this.notes,
      checkInMethod: checkInMethod ?? this.checkInMethod,
      checkOutMethod: checkOutMethod ?? this.checkOutMethod,
      checkInLocation: checkInLocation ?? this.checkInLocation,
      checkOutLocation: checkOutLocation ?? this.checkOutLocation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

