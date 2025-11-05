import 'package:equatable/equatable.dart';

/// Leave type entity
class LeaveType extends Equatable {
  final String id;
  final String name;
  final String code; // annual, sick, emergency, etc.
  final String? description;
  final int defaultDaysPerYear;
  final bool isPaid;
  final bool requiresApproval;
  final bool requiresDocument; // e.g., sick leave requires medical certificate
  final int maxConsecutiveDays;
  final int minDaysNotice; // Minimum days notice required before leave
  final bool canCarryForward; // Can unused days be carried to next year
  final int maxCarryForwardDays;
  final String? color; // For UI display
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const LeaveType({
    required this.id,
    required this.name,
    required this.code,
    this.description,
    required this.defaultDaysPerYear,
    this.isPaid = true,
    this.requiresApproval = true,
    this.requiresDocument = false,
    this.maxConsecutiveDays = 30,
    this.minDaysNotice = 1,
    this.canCarryForward = false,
    this.maxCarryForwardDays = 0,
    this.color,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        code,
        description,
        defaultDaysPerYear,
        isPaid,
        requiresApproval,
        requiresDocument,
        maxConsecutiveDays,
        minDaysNotice,
        canCarryForward,
        maxCarryForwardDays,
        color,
        isActive,
        createdAt,
        updatedAt,
      ];

  LeaveType copyWith({
    String? id,
    String? name,
    String? code,
    String? description,
    int? defaultDaysPerYear,
    bool? isPaid,
    bool? requiresApproval,
    bool? requiresDocument,
    int? maxConsecutiveDays,
    int? minDaysNotice,
    bool? canCarryForward,
    int? maxCarryForwardDays,
    String? color,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LeaveType(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      description: description ?? this.description,
      defaultDaysPerYear: defaultDaysPerYear ?? this.defaultDaysPerYear,
      isPaid: isPaid ?? this.isPaid,
      requiresApproval: requiresApproval ?? this.requiresApproval,
      requiresDocument: requiresDocument ?? this.requiresDocument,
      maxConsecutiveDays: maxConsecutiveDays ?? this.maxConsecutiveDays,
      minDaysNotice: minDaysNotice ?? this.minDaysNotice,
      canCarryForward: canCarryForward ?? this.canCarryForward,
      maxCarryForwardDays: maxCarryForwardDays ?? this.maxCarryForwardDays,
      color: color ?? this.color,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

