import 'package:equatable/equatable.dart';

/// Document entity
class Document extends Equatable {
  final String id;
  final String employeeId;
  final String? employeeName;
  final String title;
  final String category; // personal, educational, professional, medical, contract, certificate, other
  final String? description;
  final String fileName;
  final String filePath;
  final String fileType; // pdf, doc, docx, jpg, png, etc.
  final int fileSize; // in bytes
  final DateTime? issueDate;
  final DateTime? expiryDate;
  final String? issuedBy;
  final String? documentNumber;
  final int version;
  final bool isVerified;
  final DateTime? verifiedAt;
  final String? verifiedBy;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Document({
    required this.id,
    required this.employeeId,
    this.employeeName,
    required this.title,
    required this.category,
    this.description,
    required this.fileName,
    required this.filePath,
    required this.fileType,
    required this.fileSize,
    this.issueDate,
    this.expiryDate,
    this.issuedBy,
    this.documentNumber,
    this.version = 1,
    this.isVerified = false,
    this.verifiedAt,
    this.verifiedBy,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        employeeId,
        employeeName,
        title,
        category,
        description,
        fileName,
        filePath,
        fileType,
        fileSize,
        issueDate,
        expiryDate,
        issuedBy,
        documentNumber,
        version,
        isVerified,
        verifiedAt,
        verifiedBy,
        notes,
        createdAt,
        updatedAt,
      ];

  Document copyWith({
    String? id,
    String? employeeId,
    String? employeeName,
    String? title,
    String? category,
    String? description,
    String? fileName,
    String? filePath,
    String? fileType,
    int? fileSize,
    DateTime? issueDate,
    DateTime? expiryDate,
    String? issuedBy,
    String? documentNumber,
    int? version,
    bool? isVerified,
    DateTime? verifiedAt,
    String? verifiedBy,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Document(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      fileType: fileType ?? this.fileType,
      fileSize: fileSize ?? this.fileSize,
      issueDate: issueDate ?? this.issueDate,
      expiryDate: expiryDate ?? this.expiryDate,
      issuedBy: issuedBy ?? this.issuedBy,
      documentNumber: documentNumber ?? this.documentNumber,
      version: version ?? this.version,
      isVerified: isVerified ?? this.isVerified,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      verifiedBy: verifiedBy ?? this.verifiedBy,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

