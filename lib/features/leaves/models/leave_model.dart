import 'package:flutter/material.dart';

enum LeaveTypeStatus { active, inactive }
enum LeaveRequestStatus { pending, approved, rejected, cancelled }

class LeaveType {
  final int? id;
  final String name;
  final String description;
  final double defaultDays;
  final LeaveTypeStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  LeaveType({
    this.id,
    required this.name,
    this.description = '',
    required this.defaultDays,
    this.status = LeaveTypeStatus.active,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LeaveType.fromMap(Map<String, dynamic> map) {
    return LeaveType(
      id: map['id'],
      name: map['name'],
      description: map['description'] ?? '',
      defaultDays: map['default_days']?.toDouble() ?? 0.0,
      status: (map['status'] == 'active') ? LeaveTypeStatus.active : LeaveTypeStatus.inactive,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'default_days': defaultDays,
      'status': status.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  LeaveType copyWith({
    int? id,
    String? name,
    String? description,
    double? defaultDays,
    LeaveTypeStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LeaveType(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      defaultDays: defaultDays ?? this.defaultDays,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class LeaveRequest {
  final int? id;
  final int employeeId;
  final int leaveTypeId;
  final DateTime startDate;
  final DateTime endDate;
  final double totalDays;
  final String reason;
  final LeaveRequestStatus status;
  final int? approvedBy;
  final String? approverComments;
  final DateTime createdAt;
  final DateTime updatedAt;

  LeaveRequest({
    this.id,
    required this.employeeId,
    required this.leaveTypeId,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    this.reason = '',
    this.status = LeaveRequestStatus.pending,
    this.approvedBy,
    this.approverComments,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LeaveRequest.fromMap(Map<String, dynamic> map) {
    return LeaveRequest(
      id: map['id'],
      employeeId: map['employee_id'],
      leaveTypeId: map['leave_type_id'],
      startDate: DateTime.parse(map['start_date']),
      endDate: DateTime.parse(map['end_date']),
      totalDays: map['total_days']?.toDouble() ?? 0.0,
      reason: map['reason'] ?? '',
      status: LeaveRequestStatus.values.firstWhere((e) => e.name == map['status'], orElse: () => LeaveRequestStatus.pending),
      approvedBy: map['approved_by'],
      approverComments: map['approver_comments'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employee_id': employeeId,
      'leave_type_id': leaveTypeId,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'total_days': totalDays,
      'reason': reason,
      'status': status.name,
      'approved_by': approvedBy,
      'approver_comments': approverComments,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  LeaveRequest copyWith({
    int? id,
    int? employeeId,
    int? leaveTypeId,
    DateTime? startDate,
    DateTime? endDate,
    double? totalDays,
    String? reason,
    LeaveRequestStatus? status,
    int? approvedBy,
    String? approverComments,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LeaveRequest(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      leaveTypeId: leaveTypeId ?? this.leaveTypeId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalDays: totalDays ?? this.totalDays,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      approvedBy: approvedBy ?? this.approvedBy,
      approverComments: approverComments ?? this.approverComments,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Color get statusColor {
    switch (status) {
      case LeaveRequestStatus.pending:
        return Colors.orange;
      case LeaveRequestStatus.approved:
        return Colors.green;
      case LeaveRequestStatus.rejected:
        return Colors.red;
      case LeaveRequestStatus.cancelled:
        return Colors.grey;
    }
  }
}