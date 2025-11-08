enum PayrollPeriodStatus { open, closed, processed }

enum SalaryComponentType { basic, allowance, deduction, bonus }

enum CalculationType { fixed, percentage }

enum PaymentStatus { pending, paid, failed }

class PayrollPeriod {
  final int? id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final PayrollPeriodStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  PayrollPeriod({
    this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    this.status = PayrollPeriodStatus.open,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PayrollPeriod.fromMap(Map<String, dynamic> map) {
    return PayrollPeriod(
      id: map['id'],
      name: map['name'],
      startDate: DateTime.parse(map['start_date']),
      endDate: DateTime.parse(map['end_date']),
      status:
          PayrollPeriodStatus.values.firstWhere((e) => e.name == map['status']),
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'status': status.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  PayrollPeriod copyWith({
    int? id,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    PayrollPeriodStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PayrollPeriod(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SalaryComponent {
  final int? id;
  final String code;
  final String name;
  final SalaryComponentType type;
  final CalculationType calculationType;
  final double? amount;
  final double? percentage;
  final bool isTaxable;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  SalaryComponent({
    this.id,
    required this.code,
    required this.name,
    required this.type,
    required this.calculationType,
    this.amount,
    this.percentage,
    this.isTaxable = false,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SalaryComponent.fromMap(Map<String, dynamic> map) {
    return SalaryComponent(
      id: map['id'],
      code: map['code'],
      name: map['name'],
      type: SalaryComponentType.values.firstWhere((e) => e.name == map['type']),
      calculationType: CalculationType.values
          .firstWhere((e) => e.name == map['calculation_type']),
      amount: map['amount'],
      percentage: map['percentage'],
      isTaxable: map['is_taxable'] == 1,
      isActive: map['is_active'] == 1,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'type': type.name,
      'calculation_type': calculationType.name,
      'amount': amount,
      'percentage': percentage,
      'is_taxable': isTaxable ? 1 : 0,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  SalaryComponent copyWith({
    int? id,
    String? code,
    String? name,
    SalaryComponentType? type,
    CalculationType? calculationType,
    double? amount,
    double? percentage,
    bool? isTaxable,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SalaryComponent(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      type: type ?? this.type,
      calculationType: calculationType ?? this.calculationType,
      amount: amount ?? this.amount,
      percentage: percentage ?? this.percentage,
      isTaxable: isTaxable ?? this.isTaxable,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class EmployeeSalary {
  final int? id;
  final int employeeId;
  final int payrollPeriodId;
  final double basicSalary;
  final double totalAllowances;
  final double totalDeductions;
  final double netSalary;
  final PaymentStatus paymentStatus;
  final DateTime? paymentDate;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  EmployeeSalary({
    this.id,
    required this.employeeId,
    required this.payrollPeriodId,
    required this.basicSalary,
    this.totalAllowances = 0,
    this.totalDeductions = 0,
    required this.netSalary,
    this.paymentStatus = PaymentStatus.pending,
    this.paymentDate,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EmployeeSalary.fromMap(Map<String, dynamic> map) {
    return EmployeeSalary(
      id: map['id'],
      employeeId: map['employee_id'],
      payrollPeriodId: map['payroll_period_id'],
      basicSalary: map['basic_salary'],
      totalAllowances: map['total_allowances'],
      totalDeductions: map['total_deductions'],
      netSalary: map['net_salary'],
      paymentStatus: PaymentStatus.values
          .firstWhere((e) => e.name == map['payment_status']),
      paymentDate: map['payment_date'] != null
          ? DateTime.parse(map['payment_date'])
          : null,
      notes: map['notes'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employee_id': employeeId,
      'payroll_period_id': payrollPeriodId,
      'basic_salary': basicSalary,
      'total_allowances': totalAllowances,
      'total_deductions': totalDeductions,
      'net_salary': netSalary,
      'payment_status': paymentStatus.name,
      'payment_date': paymentDate?.toIso8601String(),
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  EmployeeSalary copyWith({
    int? id,
    int? employeeId,
    int? payrollPeriodId,
    double? basicSalary,
    double? totalAllowances,
    double? totalDeductions,
    double? netSalary,
    PaymentStatus? paymentStatus,
    DateTime? paymentDate,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EmployeeSalary(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      payrollPeriodId: payrollPeriodId ?? this.payrollPeriodId,
      basicSalary: basicSalary ?? this.basicSalary,
      totalAllowances: totalAllowances ?? this.totalAllowances,
      totalDeductions: totalDeductions ?? this.totalDeductions,
      netSalary: netSalary ?? this.netSalary,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentDate: paymentDate ?? this.paymentDate,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
