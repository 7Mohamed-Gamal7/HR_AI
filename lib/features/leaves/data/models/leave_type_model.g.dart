// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveTypeModelImpl _$$LeaveTypeModelImplFromJson(Map<String, dynamic> json) =>
    _$LeaveTypeModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      defaultDays: (json['defaultDays'] as num).toInt(),
      maxDays: (json['maxDays'] as num?)?.toInt() ?? 0,
      requiresApproval: json['requiresApproval'] as bool? ?? false,
      isPaid: json['isPaid'] as bool? ?? false,
      carryForward: json['carryForward'] as bool? ?? false,
      maxCarryForwardDays: (json['maxCarryForwardDays'] as num?)?.toInt() ?? 0,
      requiresDocument: json['requiresDocument'] as bool? ?? false,
      color: json['color'] as String?,
      icon: json['icon'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$LeaveTypeModelImplToJson(
        _$LeaveTypeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'defaultDays': instance.defaultDays,
      'maxDays': instance.maxDays,
      'requiresApproval': instance.requiresApproval,
      'isPaid': instance.isPaid,
      'carryForward': instance.carryForward,
      'maxCarryForwardDays': instance.maxCarryForwardDays,
      'requiresDocument': instance.requiresDocument,
      'color': instance.color,
      'icon': instance.icon,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
