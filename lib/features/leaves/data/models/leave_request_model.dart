import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/leave_request.dart';

part 'leave_request_model.freezed.dart';
part 'leave_request_model.g.dart';

/// LeaveRequest data model with JSON serialization
@freezed
class LeaveRequestModel with _$LeaveRequestModel {
  const LeaveRequestModel._();

  const factory LeaveRequestModel({
    required String id,
    required String employeeId,
    String? employeeName,
    required String leaveTypeId,
    String? leaveTypeName,
    required DateTime startDate,
    required DateTime endDate,
    required int numberOfDays,
    required String status,
    String? reason,
    String? rejectionReason,
    String? approverId,
    String? approverName,
    DateTime? approvedAt,
    String? documentPath,
    @Default(false) bool isEmergency,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _LeaveRequestModel;

  /// Create from JSON
  factory LeaveRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestModelFromJson(json);

  /// Create from domain entity
  factory LeaveRequestModel.fromEntity(LeaveRequest entity) {
    return LeaveRequestModel(
      id: entity.id,
      employeeId: entity.employeeId,
      employeeName: entity.employeeName,
      leaveTypeId: entity.leaveTypeId,
      leaveTypeName: entity.leaveTypeName,
      startDate: entity.startDate,
      endDate: entity.endDate,
      numberOfDays: entity.numberOfDays,
      status: entity.status,
      reason: entity.reason,
      rejectionReason: entity.rejectionReason,
      approverId: entity.approverId,
      approverName: entity.approverName,
      approvedAt: entity.approvedAt,
      documentPath: entity.documentPath,
      isEmergency: entity.isEmergency,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Convert to domain entity
  LeaveRequest toEntity() {
    return LeaveRequest(
      id: id,
      employeeId: employeeId,
      employeeName: employeeName,
      leaveTypeId: leaveTypeId,
      leaveTypeName: leaveTypeName,
      startDate: startDate,
      endDate: endDate,
      numberOfDays: numberOfDays,
      status: status,
      reason: reason,
      rejectionReason: rejectionReason,
      approverId: approverId,
      approverName: approverName,
      approvedAt: approvedAt,
      documentPath: documentPath,
      isEmergency: isEmergency,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from database map
  factory LeaveRequestModel.fromDatabase(Map<String, dynamic> map) {
    return LeaveRequestModel(
      id: map['id'] as String,
      employeeId: map['employee_id'] as String,
      employeeName: map['employee_name'] as String?,
      leaveTypeId: map['leave_type_id'] as String,
      leaveTypeName: map['leave_type_name'] as String?,
      startDate: DateTime.parse(map['start_date'] as String),
      endDate: DateTime.parse(map['end_date'] as String),
      numberOfDays: map['number_of_days'] as int,
      status: map['status'] as String,
      reason: map['reason'] as String?,
      rejectionReason: map['rejection_reason'] as String?,
      approverId: map['approver_id'] as String?,
      approverName: map['approver_name'] as String?,
      approvedAt: map['approved_at'] != null
          ? DateTime.parse(map['approved_at'] as String)
          : null,
      documentPath: map['document_path'] as String?,
      isEmergency: (map['is_emergency'] as int?) == 1,
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
      'leave_type_id': leaveTypeId,
      'start_date': startDate.toIso8601String().split('T')[0],
      'end_date': endDate.toIso8601String().split('T')[0],
      'number_of_days': numberOfDays,
      'status': status,
      'reason': reason,
      'rejection_reason': rejectionReason,
      'approver_id': approverId,
      'approved_at': approvedAt?.toIso8601String(),
      'document_path': documentPath,
      'is_emergency': isEmergency ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

