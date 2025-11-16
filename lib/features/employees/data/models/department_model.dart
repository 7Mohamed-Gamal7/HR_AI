import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/department.dart';

part 'department_model.freezed.dart';
part 'department_model.g.dart';

/// Department data model with JSON serialization
@freezed
class DepartmentModel with _$DepartmentModel {
  const DepartmentModel._();

  const factory DepartmentModel({
    required String id,
    required String name,
    String? description,
    String? managerId,
    String? managerName,
    @Default(0) int employeeCount,
    @Default(true) bool isActive,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _DepartmentModel;

  /// Create from JSON
  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentModelFromJson(json);

  /// Create from domain entity
  factory DepartmentModel.fromEntity(Department entity) {
    return DepartmentModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      managerId: entity.managerId,
      managerName: entity.managerName,
      employeeCount: entity.employeeCount,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Convert to domain entity
  Department toEntity() {
    return Department(
      id: id,
      name: name,
      description: description,
      managerId: managerId,
      managerName: managerName,
      employeeCount: employeeCount,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from database map
  factory DepartmentModel.fromDatabase(Map<String, dynamic> map) {
    return DepartmentModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      managerId: map['manager_id'] as String?,
      managerName: map['manager_name'] as String?,
      employeeCount: map['employee_count'] as int? ?? 0,
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
      'manager_id': managerId,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

