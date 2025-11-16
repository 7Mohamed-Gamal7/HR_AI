import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/leave_type.dart';

part 'leave_type_model.freezed.dart';
part 'leave_type_model.g.dart';

/// LeaveType data model with JSON serialization
@freezed
class LeaveTypeModel with _$LeaveTypeModel {
  const LeaveTypeModel._();

  const factory LeaveTypeModel({
    required String id,
    required String name,
    String? description,
    required int defaultDays,
    @Default(0) int maxDays,
    @Default(false) bool requiresApproval,
    @Default(false) bool isPaid,
    @Default(false) bool carryForward,
    @Default(0) int maxCarryForwardDays,
    @Default(false) bool requiresDocument,
    String? color,
    String? icon,
    @Default(true) bool isActive,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _LeaveTypeModel;

  /// Create from JSON
  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypeModelFromJson(json);

  /// Create from domain entity
  factory LeaveTypeModel.fromEntity(LeaveType entity) {
    return LeaveTypeModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      defaultDays: entity.defaultDays,
      maxDays: entity.maxDays,
      requiresApproval: entity.requiresApproval,
      isPaid: entity.isPaid,
      carryForward: entity.carryForward,
      maxCarryForwardDays: entity.maxCarryForwardDays,
      requiresDocument: entity.requiresDocument,
      color: entity.color,
      icon: entity.icon,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Convert to domain entity
  LeaveType toEntity() {
    return LeaveType(
      id: id,
      name: name,
      description: description,
      defaultDays: defaultDays,
      maxDays: maxDays,
      requiresApproval: requiresApproval,
      isPaid: isPaid,
      carryForward: carryForward,
      maxCarryForwardDays: maxCarryForwardDays,
      requiresDocument: requiresDocument,
      color: color,
      icon: icon,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from database map
  factory LeaveTypeModel.fromDatabase(Map<String, dynamic> map) {
    return LeaveTypeModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      defaultDays: map['default_days'] as int,
      maxDays: map['max_days'] as int? ?? 0,
      requiresApproval: (map['requires_approval'] as int?) == 1,
      isPaid: (map['is_paid'] as int?) == 1,
      carryForward: (map['carry_forward'] as int?) == 1,
      maxCarryForwardDays: map['max_carry_forward_days'] as int? ?? 0,
      requiresDocument: (map['requires_document'] as int?) == 1,
      color: map['color'] as String?,
      icon: map['icon'] as String?,
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
      'default_days': defaultDays,
      'max_days': maxDays,
      'requires_approval': requiresApproval ? 1 : 0,
      'is_paid': isPaid ? 1 : 0,
      'carry_forward': carryForward ? 1 : 0,
      'max_carry_forward_days': maxCarryForwardDays,
      'requires_document': requiresDocument ? 1 : 0,
      'color': color,
      'icon': icon,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

