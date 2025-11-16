import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/leave_balance.dart';

part 'leave_balance_model.freezed.dart';
part 'leave_balance_model.g.dart';

/// LeaveBalance data model with JSON serialization
@freezed
class LeaveBalanceModel with _$LeaveBalanceModel {
  const LeaveBalanceModel._();

  const factory LeaveBalanceModel({
    required String id,
    required String employeeId,
    String? employeeName,
    required String leaveTypeId,
    String? leaveTypeName,
    required int year,
    required int totalDays,
    @Default(0) int usedDays,
    @Default(0) int pendingDays,
    @Default(0) int remainingDays,
    @Default(0) int carriedForwardDays,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _LeaveBalanceModel;

  /// Create from JSON
  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveBalanceModelFromJson(json);

  /// Create from domain entity
  factory LeaveBalanceModel.fromEntity(LeaveBalance entity) {
    return LeaveBalanceModel(
      id: entity.id,
      employeeId: entity.employeeId,
      employeeName: entity.employeeName,
      leaveTypeId: entity.leaveTypeId,
      leaveTypeName: entity.leaveTypeName,
      year: entity.year,
      totalDays: entity.totalDays,
      usedDays: entity.usedDays,
      pendingDays: entity.pendingDays,
      remainingDays: entity.remainingDays,
      carriedForwardDays: entity.carriedForwardDays,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Convert to domain entity
  LeaveBalance toEntity() {
    return LeaveBalance(
      id: id,
      employeeId: employeeId,
      employeeName: employeeName,
      leaveTypeId: leaveTypeId,
      leaveTypeName: leaveTypeName,
      year: year,
      totalDays: totalDays,
      usedDays: usedDays,
      pendingDays: pendingDays,
      remainingDays: remainingDays,
      carriedForwardDays: carriedForwardDays,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from database map
  factory LeaveBalanceModel.fromDatabase(Map<String, dynamic> map) {
    return LeaveBalanceModel(
      id: map['id'] as String,
      employeeId: map['employee_id'] as String,
      employeeName: map['employee_name'] as String?,
      leaveTypeId: map['leave_type_id'] as String,
      leaveTypeName: map['leave_type_name'] as String?,
      year: map['year'] as int,
      totalDays: map['total_days'] as int,
      usedDays: map['used_days'] as int? ?? 0,
      pendingDays: map['pending_days'] as int? ?? 0,
      remainingDays: map['remaining_days'] as int? ?? 0,
      carriedForwardDays: map['carried_forward_days'] as int? ?? 0,
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
      'year': year,
      'total_days': totalDays,
      'used_days': usedDays,
      'pending_days': pendingDays,
      'remaining_days': remainingDays,
      'carried_forward_days': carriedForwardDays,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

