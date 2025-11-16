import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/holiday.dart';

part 'holiday_model.freezed.dart';
part 'holiday_model.g.dart';

/// Holiday data model with JSON serialization
@freezed
class HolidayModel with _$HolidayModel {
  const HolidayModel._();

  const factory HolidayModel({
    required String id,
    required String name,
    String? description,
    required DateTime date,
    DateTime? endDate,
    @Default(true) bool isPaid,
    @Default(false) bool isRecurring,
    String? country,
    @Default(true) bool isActive,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _HolidayModel;

  /// Create from JSON
  factory HolidayModel.fromJson(Map<String, dynamic> json) =>
      _$HolidayModelFromJson(json);

  /// Create from domain entity
  factory HolidayModel.fromEntity(Holiday entity) {
    return HolidayModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      date: entity.date,
      endDate: entity.endDate,
      isPaid: entity.isPaid,
      isRecurring: entity.isRecurring,
      country: entity.country,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Convert to domain entity
  Holiday toEntity() {
    return Holiday(
      id: id,
      name: name,
      description: description,
      date: date,
      endDate: endDate,
      isPaid: isPaid,
      isRecurring: isRecurring,
      country: country,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from database map
  factory HolidayModel.fromDatabase(Map<String, dynamic> map) {
    return HolidayModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      date: DateTime.parse(map['date'] as String),
      endDate: map['end_date'] != null
          ? DateTime.parse(map['end_date'] as String)
          : null,
      isPaid: (map['is_paid'] as int?) == 1,
      isRecurring: (map['is_recurring'] as int?) == 1,
      country: map['country'] as String?,
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
      'name': name,
      'description': description,
      'date': date.toIso8601String().split('T')[0],
      'end_date': endDate?.toIso8601String().split('T')[0],
      'is_paid': isPaid ? 1 : 0,
      'is_recurring': isRecurring ? 1 : 0,
      'country': country,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

