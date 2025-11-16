import 'package:equatable/equatable.dart';

/// Holiday entity
class Holiday extends Equatable {
  final String id;
  final String name;
  final String? description;
  final DateTime date;
  final DateTime? endDate; // For multi-day holidays
  final bool isPaid;
  final bool isRecurring; // Annual recurring holiday
  final String? country;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Holiday({
    required this.id,
    required this.name,
    this.description,
    required this.date,
    this.endDate,
    this.isPaid = true,
    this.isRecurring = false,
    this.country,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        date,
        endDate,
        isPaid,
        isRecurring,
        country,
        isActive,
        createdAt,
        updatedAt,
      ];

  Holiday copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? date,
    DateTime? endDate,
    bool? isPaid,
    bool? isRecurring,
    String? country,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Holiday(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      date: date ?? this.date,
      endDate: endDate ?? this.endDate,
      isPaid: isPaid ?? this.isPaid,
      isRecurring: isRecurring ?? this.isRecurring,
      country: country ?? this.country,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

