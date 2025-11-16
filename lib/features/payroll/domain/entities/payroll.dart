import 'package:equatable/equatable.dart';

/// Payroll entity
class Payroll extends Equatable {
  final String id;
  final String employeeId;
  final String? employeeName;
  final int month;
  final int year;
  final DateTime payPeriodStart;
  final DateTime payPeriodEnd;
  
  // Salary components
  final double basicSalary;
  final double allowances;
  final double bonuses;
  final double overtimePay;
  final double deductions;
  final double penalties;
  final double taxAmount;
  final double insuranceDeduction;
  final double loanDeduction;
  final double advanceDeduction;
  
  // Attendance-based calculations
  final int workingDays;
  final int presentDays;
  final int absentDays;
  final int leaveDays;
  final int paidLeaveDays;
  final int unpaidLeaveDays;
  final double overtimeHours;
  
  // Totals
  final double grossSalary;
  final double totalDeductions;
  final double netSalary;
  
  final String status; // draft, pending, approved, paid
  final DateTime? paidDate;
  final String? paymentMethod;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Payroll({
    required this.id,
    required this.employeeId,
    this.employeeName,
    required this.month,
    required this.year,
    required this.payPeriodStart,
    required this.payPeriodEnd,
    required this.basicSalary,
    this.allowances = 0,
    this.bonuses = 0,
    this.overtimePay = 0,
    this.deductions = 0,
    this.penalties = 0,
    this.taxAmount = 0,
    this.insuranceDeduction = 0,
    this.loanDeduction = 0,
    this.advanceDeduction = 0,
    required this.workingDays,
    required this.presentDays,
    this.absentDays = 0,
    this.leaveDays = 0,
    this.paidLeaveDays = 0,
    this.unpaidLeaveDays = 0,
    this.overtimeHours = 0,
    required this.grossSalary,
    required this.totalDeductions,
    required this.netSalary,
    required this.status,
    this.paidDate,
    this.paymentMethod,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        employeeId,
        employeeName,
        month,
        year,
        payPeriodStart,
        payPeriodEnd,
        basicSalary,
        allowances,
        bonuses,
        overtimePay,
        deductions,
        penalties,
        taxAmount,
        insuranceDeduction,
        loanDeduction,
        advanceDeduction,
        workingDays,
        presentDays,
        absentDays,
        leaveDays,
        paidLeaveDays,
        unpaidLeaveDays,
        overtimeHours,
        grossSalary,
        totalDeductions,
        netSalary,
        status,
        paidDate,
        paymentMethod,
        notes,
        createdAt,
        updatedAt,
      ];

  Payroll copyWith({
    String? id,
    String? employeeId,
    String? employeeName,
    int? month,
    int? year,
    DateTime? payPeriodStart,
    DateTime? payPeriodEnd,
    double? basicSalary,
    double? allowances,
    double? bonuses,
    double? overtimePay,
    double? deductions,
    double? penalties,
    double? taxAmount,
    double? insuranceDeduction,
    double? loanDeduction,
    double? advanceDeduction,
    int? workingDays,
    int? presentDays,
    int? absentDays,
    int? leaveDays,
    int? paidLeaveDays,
    int? unpaidLeaveDays,
    double? overtimeHours,
    double? grossSalary,
    double? totalDeductions,
    double? netSalary,
    String? status,
    DateTime? paidDate,
    String? paymentMethod,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Payroll(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      month: month ?? this.month,
      year: year ?? this.year,
      payPeriodStart: payPeriodStart ?? this.payPeriodStart,
      payPeriodEnd: payPeriodEnd ?? this.payPeriodEnd,
      basicSalary: basicSalary ?? this.basicSalary,
      allowances: allowances ?? this.allowances,
      bonuses: bonuses ?? this.bonuses,
      overtimePay: overtimePay ?? this.overtimePay,
      deductions: deductions ?? this.deductions,
      penalties: penalties ?? this.penalties,
      taxAmount: taxAmount ?? this.taxAmount,
      insuranceDeduction: insuranceDeduction ?? this.insuranceDeduction,
      loanDeduction: loanDeduction ?? this.loanDeduction,
      advanceDeduction: advanceDeduction ?? this.advanceDeduction,
      workingDays: workingDays ?? this.workingDays,
      presentDays: presentDays ?? this.presentDays,
      absentDays: absentDays ?? this.absentDays,
      leaveDays: leaveDays ?? this.leaveDays,
      paidLeaveDays: paidLeaveDays ?? this.paidLeaveDays,
      unpaidLeaveDays: unpaidLeaveDays ?? this.unpaidLeaveDays,
      overtimeHours: overtimeHours ?? this.overtimeHours,
      grossSalary: grossSalary ?? this.grossSalary,
      totalDeductions: totalDeductions ?? this.totalDeductions,
      netSalary: netSalary ?? this.netSalary,
      status: status ?? this.status,
      paidDate: paidDate ?? this.paidDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

