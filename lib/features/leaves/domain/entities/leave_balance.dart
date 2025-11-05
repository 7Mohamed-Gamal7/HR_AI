import 'package:equatable/equatable.dart';

/// Leave balance entity
class LeaveBalance extends Equatable {
  final String id;
  final String employeeId;
  final String? employeeName;
  final String leaveTypeId;
  final String? leaveTypeName;
  final int year;
  final double totalDays;
  final double usedDays;
  final double remainingDays;
  final double carriedForwardDays;
  final DateTime? lastUpdated;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const LeaveBalance({
    required this.id,
    required this.employeeId,
    this.employeeName,
    required this.leaveTypeId,
    this.leaveTypeName,
    required this.year,
    required this.totalDays,
    this.usedDays = 0,
    required this.remainingDays,
    this.carriedForwardDays = 0,
    this.lastUpdated,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        employeeId,
        employeeName,
        leaveTypeId,
        leaveTypeName,
        year,
        totalDays,
        usedDays,
        remainingDays,
        carriedForwardDays,
        lastUpdated,
        createdAt,
        updatedAt,
      ];

  LeaveBalance copyWith({
    String? id,
    String? employeeId,
    String? employeeName,
    String? leaveTypeId,
    String? leaveTypeName,
    int? year,
    double? totalDays,
    double? usedDays,
    double? remainingDays,
    double? carriedForwardDays,
    DateTime? lastUpdated,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LeaveBalance(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      leaveTypeId: leaveTypeId ?? this.leaveTypeId,
      leaveTypeName: leaveTypeName ?? this.leaveTypeName,
      year: year ?? this.year,
      totalDays: totalDays ?? this.totalDays,
      usedDays: usedDays ?? this.usedDays,
      remainingDays: remainingDays ?? this.remainingDays,
      carriedForwardDays: carriedForwardDays ?? this.carriedForwardDays,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

