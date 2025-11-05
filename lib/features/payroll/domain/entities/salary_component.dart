import 'package:equatable/equatable.dart';

/// Salary component entity (allowances, deductions, etc.)
class SalaryComponent extends Equatable {
  final String id;
  final String employeeId;
  final String? employeeName;
  final String name;
  final String type; // allowance, deduction, bonus, penalty
  final double amount;
  final bool isPercentage; // If true, amount is percentage of basic salary
  final bool isRecurring; // If true, applies every month
  final bool isTaxable;
  final DateTime? effectiveFrom;
  final DateTime? effectiveTo;
  final String? description;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const SalaryComponent({
    required this.id,
    required this.employeeId,
    this.employeeName,
    required this.name,
    required this.type,
    required this.amount,
    this.isPercentage = false,
    this.isRecurring = true,
    this.isTaxable = true,
    this.effectiveFrom,
    this.effectiveTo,
    this.description,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        employeeId,
        employeeName,
        name,
        type,
        amount,
        isPercentage,
        isRecurring,
        isTaxable,
        effectiveFrom,
        effectiveTo,
        description,
        isActive,
        createdAt,
        updatedAt,
      ];

  SalaryComponent copyWith({
    String? id,
    String? employeeId,
    String? employeeName,
    String? name,
    String? type,
    double? amount,
    bool? isPercentage,
    bool? isRecurring,
    bool? isTaxable,
    DateTime? effectiveFrom,
    DateTime? effectiveTo,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SalaryComponent(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      name: name ?? this.name,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      isPercentage: isPercentage ?? this.isPercentage,
      isRecurring: isRecurring ?? this.isRecurring,
      isTaxable: isTaxable ?? this.isTaxable,
      effectiveFrom: effectiveFrom ?? this.effectiveFrom,
      effectiveTo: effectiveTo ?? this.effectiveTo,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

