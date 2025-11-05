import 'package:equatable/equatable.dart';

/// Contract entity
class Contract extends Equatable {
  final String id;
  final String employeeId;
  final String? employeeName;
  final String contractNumber;
  final String contractType; // permanent, temporary, part_time, contract, internship
  final DateTime startDate;
  final DateTime? endDate;
  final int? durationMonths;
  final double salary;
  final String? currency;
  final String? jobTitle;
  final String? department;
  final String? workLocation;
  final int workHoursPerWeek;
  final int probationPeriodMonths;
  final int noticePeriodDays;
  final String? terms;
  final String? benefits;
  final String status; // draft, active, expired, terminated, renewed
  final DateTime? signedDate;
  final String? documentPath;
  final bool autoRenew;
  final int? renewalNoticeDays;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Contract({
    required this.id,
    required this.employeeId,
    this.employeeName,
    required this.contractNumber,
    required this.contractType,
    required this.startDate,
    this.endDate,
    this.durationMonths,
    required this.salary,
    this.currency,
    this.jobTitle,
    this.department,
    this.workLocation,
    this.workHoursPerWeek = 40,
    this.probationPeriodMonths = 3,
    this.noticePeriodDays = 30,
    this.terms,
    this.benefits,
    required this.status,
    this.signedDate,
    this.documentPath,
    this.autoRenew = false,
    this.renewalNoticeDays,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        employeeId,
        employeeName,
        contractNumber,
        contractType,
        startDate,
        endDate,
        durationMonths,
        salary,
        currency,
        jobTitle,
        department,
        workLocation,
        workHoursPerWeek,
        probationPeriodMonths,
        noticePeriodDays,
        terms,
        benefits,
        status,
        signedDate,
        documentPath,
        autoRenew,
        renewalNoticeDays,
        notes,
        createdAt,
        updatedAt,
      ];

  Contract copyWith({
    String? id,
    String? employeeId,
    String? employeeName,
    String? contractNumber,
    String? contractType,
    DateTime? startDate,
    DateTime? endDate,
    int? durationMonths,
    double? salary,
    String? currency,
    String? jobTitle,
    String? department,
    String? workLocation,
    int? workHoursPerWeek,
    int? probationPeriodMonths,
    int? noticePeriodDays,
    String? terms,
    String? benefits,
    String? status,
    DateTime? signedDate,
    String? documentPath,
    bool? autoRenew,
    int? renewalNoticeDays,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Contract(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      contractNumber: contractNumber ?? this.contractNumber,
      contractType: contractType ?? this.contractType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      durationMonths: durationMonths ?? this.durationMonths,
      salary: salary ?? this.salary,
      currency: currency ?? this.currency,
      jobTitle: jobTitle ?? this.jobTitle,
      department: department ?? this.department,
      workLocation: workLocation ?? this.workLocation,
      workHoursPerWeek: workHoursPerWeek ?? this.workHoursPerWeek,
      probationPeriodMonths: probationPeriodMonths ?? this.probationPeriodMonths,
      noticePeriodDays: noticePeriodDays ?? this.noticePeriodDays,
      terms: terms ?? this.terms,
      benefits: benefits ?? this.benefits,
      status: status ?? this.status,
      signedDate: signedDate ?? this.signedDate,
      documentPath: documentPath ?? this.documentPath,
      autoRenew: autoRenew ?? this.autoRenew,
      renewalNoticeDays: renewalNoticeDays ?? this.renewalNoticeDays,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

