import 'package:equatable/equatable.dart';

/// Leave request entity
class LeaveRequest extends Equatable {
  final String id;
  final String employeeId;
  final String? employeeName;
  final String leaveTypeId;
  final String? leaveTypeName;
  final DateTime startDate;
  final DateTime endDate;
  final int numberOfDays;
  final String reason;
  final String status; // pending, approved, rejected, cancelled
  final String? attachmentPath;
  final String? approvedBy;
  final String? approverName;
  final DateTime? approvedAt;
  final String? rejectionReason;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const LeaveRequest({
    required this.id,
    required this.employeeId,
    this.employeeName,
    required this.leaveTypeId,
    this.leaveTypeName,
    required this.startDate,
    required this.endDate,
    required this.numberOfDays,
    required this.reason,
    required this.status,
    this.attachmentPath,
    this.approvedBy,
    this.approverName,
    this.approvedAt,
    this.rejectionReason,
    this.notes,
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
        startDate,
        endDate,
        numberOfDays,
        reason,
        status,
        attachmentPath,
        approvedBy,
        approverName,
        approvedAt,
        rejectionReason,
        notes,
        createdAt,
        updatedAt,
      ];

  LeaveRequest copyWith({
    String? id,
    String? employeeId,
    String? employeeName,
    String? leaveTypeId,
    String? leaveTypeName,
    DateTime? startDate,
    DateTime? endDate,
    int? numberOfDays,
    String? reason,
    String? status,
    String? attachmentPath,
    String? approvedBy,
    String? approverName,
    DateTime? approvedAt,
    String? rejectionReason,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LeaveRequest(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      leaveTypeId: leaveTypeId ?? this.leaveTypeId,
      leaveTypeName: leaveTypeName ?? this.leaveTypeName,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      numberOfDays: numberOfDays ?? this.numberOfDays,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      attachmentPath: attachmentPath ?? this.attachmentPath,
      approvedBy: approvedBy ?? this.approvedBy,
      approverName: approverName ?? this.approverName,
      approvedAt: approvedAt ?? this.approvedAt,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

