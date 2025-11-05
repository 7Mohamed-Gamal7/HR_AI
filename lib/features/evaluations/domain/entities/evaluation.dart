import 'package:equatable/equatable.dart';

/// Performance evaluation entity
class Evaluation extends Equatable {
  final String id;
  final String employeeId;
  final String? employeeName;
  final String evaluatorId;
  final String? evaluatorName;
  final DateTime evaluationDate;
  final String period; // monthly, quarterly, semi-annual, annual
  final DateTime periodStart;
  final DateTime periodEnd;
  
  // Evaluation criteria scores (1-5 or 1-10 scale)
  final double qualityOfWorkScore;
  final double productivityScore;
  final double communicationScore;
  final double teamworkScore;
  final double initiativeScore;
  final double punctualityScore;
  final double professionalismScore;
  final double technicalSkillsScore;
  
  // Overall
  final double overallScore;
  final double maxScore;
  final double percentage;
  final String rating; // excellent, very_good, good, satisfactory, needs_improvement
  
  final String? strengths;
  final String? weaknesses;
  final String? recommendations;
  final String? goals;
  final String? comments;
  
  final String status; // draft, submitted, reviewed, approved
  final DateTime? approvedAt;
  final String? approvedBy;
  
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Evaluation({
    required this.id,
    required this.employeeId,
    this.employeeName,
    required this.evaluatorId,
    this.evaluatorName,
    required this.evaluationDate,
    required this.period,
    required this.periodStart,
    required this.periodEnd,
    required this.qualityOfWorkScore,
    required this.productivityScore,
    required this.communicationScore,
    required this.teamworkScore,
    required this.initiativeScore,
    required this.punctualityScore,
    required this.professionalismScore,
    required this.technicalSkillsScore,
    required this.overallScore,
    this.maxScore = 5.0,
    required this.percentage,
    required this.rating,
    this.strengths,
    this.weaknesses,
    this.recommendations,
    this.goals,
    this.comments,
    required this.status,
    this.approvedAt,
    this.approvedBy,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        employeeId,
        employeeName,
        evaluatorId,
        evaluatorName,
        evaluationDate,
        period,
        periodStart,
        periodEnd,
        qualityOfWorkScore,
        productivityScore,
        communicationScore,
        teamworkScore,
        initiativeScore,
        punctualityScore,
        professionalismScore,
        technicalSkillsScore,
        overallScore,
        maxScore,
        percentage,
        rating,
        strengths,
        weaknesses,
        recommendations,
        goals,
        comments,
        status,
        approvedAt,
        approvedBy,
        createdAt,
        updatedAt,
      ];

  Evaluation copyWith({
    String? id,
    String? employeeId,
    String? employeeName,
    String? evaluatorId,
    String? evaluatorName,
    DateTime? evaluationDate,
    String? period,
    DateTime? periodStart,
    DateTime? periodEnd,
    double? qualityOfWorkScore,
    double? productivityScore,
    double? communicationScore,
    double? teamworkScore,
    double? initiativeScore,
    double? punctualityScore,
    double? professionalismScore,
    double? technicalSkillsScore,
    double? overallScore,
    double? maxScore,
    double? percentage,
    String? rating,
    String? strengths,
    String? weaknesses,
    String? recommendations,
    String? goals,
    String? comments,
    String? status,
    DateTime? approvedAt,
    String? approvedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Evaluation(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      evaluatorId: evaluatorId ?? this.evaluatorId,
      evaluatorName: evaluatorName ?? this.evaluatorName,
      evaluationDate: evaluationDate ?? this.evaluationDate,
      period: period ?? this.period,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      qualityOfWorkScore: qualityOfWorkScore ?? this.qualityOfWorkScore,
      productivityScore: productivityScore ?? this.productivityScore,
      communicationScore: communicationScore ?? this.communicationScore,
      teamworkScore: teamworkScore ?? this.teamworkScore,
      initiativeScore: initiativeScore ?? this.initiativeScore,
      punctualityScore: punctualityScore ?? this.punctualityScore,
      professionalismScore: professionalismScore ?? this.professionalismScore,
      technicalSkillsScore: technicalSkillsScore ?? this.technicalSkillsScore,
      overallScore: overallScore ?? this.overallScore,
      maxScore: maxScore ?? this.maxScore,
      percentage: percentage ?? this.percentage,
      rating: rating ?? this.rating,
      strengths: strengths ?? this.strengths,
      weaknesses: weaknesses ?? this.weaknesses,
      recommendations: recommendations ?? this.recommendations,
      goals: goals ?? this.goals,
      comments: comments ?? this.comments,
      status: status ?? this.status,
      approvedAt: approvedAt ?? this.approvedAt,
      approvedBy: approvedBy ?? this.approvedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

