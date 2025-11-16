import 'package:equatable/equatable.dart';

/// Position entity
class Position extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String departmentId;
  final String? departmentName;
  final double? minSalary;
  final double? maxSalary;
  final int level; // Job level/grade
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Position({
    required this.id,
    required this.title,
    this.description,
    required this.departmentId,
    this.departmentName,
    this.minSalary,
    this.maxSalary,
    this.level = 1,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        departmentId,
        departmentName,
        minSalary,
        maxSalary,
        level,
        isActive,
        createdAt,
        updatedAt,
      ];

  Position copyWith({
    String? id,
    String? title,
    String? description,
    String? departmentId,
    String? departmentName,
    double? minSalary,
    double? maxSalary,
    int? level,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Position(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      departmentId: departmentId ?? this.departmentId,
      departmentName: departmentName ?? this.departmentName,
      minSalary: minSalary ?? this.minSalary,
      maxSalary: maxSalary ?? this.maxSalary,
      level: level ?? this.level,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

