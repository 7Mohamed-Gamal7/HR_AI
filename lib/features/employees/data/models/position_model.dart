import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/position.dart';

part 'position_model.freezed.dart';
part 'position_model.g.dart';

/// Position data model with JSON serialization
@freezed
class PositionModel with _$PositionModel {
  const PositionModel._();

  const factory PositionModel({
    required String id,
    required String title,
    String? description,
    required String departmentId,
    String? departmentName,
    double? minSalary,
    double? maxSalary,
    @Default(1) int level,
    @Default(true) bool isActive,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _PositionModel;

  /// Create from JSON
  factory PositionModel.fromJson(Map<String, dynamic> json) =>
      _$PositionModelFromJson(json);

  /// Create from domain entity
  factory PositionModel.fromEntity(Position entity) {
    return PositionModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      departmentId: entity.departmentId,
      departmentName: entity.departmentName,
      minSalary: entity.minSalary,
      maxSalary: entity.maxSalary,
      level: entity.level,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Convert to domain entity
  Position toEntity() {
    return Position(
      id: id,
      title: title,
      description: description,
      departmentId: departmentId,
      departmentName: departmentName,
      minSalary: minSalary,
      maxSalary: maxSalary,
      level: level,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from database map
  factory PositionModel.fromDatabase(Map<String, dynamic> map) {
    return PositionModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String?,
      departmentId: map['department_id'] as String,
      departmentName: map['department_name'] as String?,
      minSalary: map['min_salary'] as double?,
      maxSalary: map['max_salary'] as double?,
      level: map['level'] as int? ?? 1,
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
      'title': title,
      'description': description,
      'department_id': departmentId,
      'min_salary': minSalary,
      'max_salary': maxSalary,
      'level': level,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

