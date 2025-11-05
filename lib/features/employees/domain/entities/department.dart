import 'package:equatable/equatable.dart';

/// Department entity
class Department extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String? managerId;
  final String? managerName;
  final int employeeCount;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Department({
    required this.id,
    required this.name,
    this.description,
    this.managerId,
    this.managerName,
    this.employeeCount = 0,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        managerId,
        managerName,
        employeeCount,
        isActive,
        createdAt,
        updatedAt,
      ];

  Department copyWith({
    String? id,
    String? name,
    String? description,
    String? managerId,
    String? managerName,
    int? employeeCount,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Department(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      managerId: managerId ?? this.managerId,
      managerName: managerName ?? this.managerName,
      employeeCount: employeeCount ?? this.employeeCount,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

