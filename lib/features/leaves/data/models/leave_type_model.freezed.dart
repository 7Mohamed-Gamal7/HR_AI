// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_type_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaveTypeModel _$LeaveTypeModelFromJson(Map<String, dynamic> json) {
  return _LeaveTypeModel.fromJson(json);
}

/// @nodoc
mixin _$LeaveTypeModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get defaultDays => throw _privateConstructorUsedError;
  int get maxDays => throw _privateConstructorUsedError;
  bool get requiresApproval => throw _privateConstructorUsedError;
  bool get isPaid => throw _privateConstructorUsedError;
  bool get carryForward => throw _privateConstructorUsedError;
  int get maxCarryForwardDays => throw _privateConstructorUsedError;
  bool get requiresDocument => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this LeaveTypeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveTypeModelCopyWith<LeaveTypeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveTypeModelCopyWith<$Res> {
  factory $LeaveTypeModelCopyWith(
          LeaveTypeModel value, $Res Function(LeaveTypeModel) then) =
      _$LeaveTypeModelCopyWithImpl<$Res, LeaveTypeModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      int defaultDays,
      int maxDays,
      bool requiresApproval,
      bool isPaid,
      bool carryForward,
      int maxCarryForwardDays,
      bool requiresDocument,
      String? color,
      String? icon,
      bool isActive,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$LeaveTypeModelCopyWithImpl<$Res, $Val extends LeaveTypeModel>
    implements $LeaveTypeModelCopyWith<$Res> {
  _$LeaveTypeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? defaultDays = null,
    Object? maxDays = null,
    Object? requiresApproval = null,
    Object? isPaid = null,
    Object? carryForward = null,
    Object? maxCarryForwardDays = null,
    Object? requiresDocument = null,
    Object? color = freezed,
    Object? icon = freezed,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultDays: null == defaultDays
          ? _value.defaultDays
          : defaultDays // ignore: cast_nullable_to_non_nullable
              as int,
      maxDays: null == maxDays
          ? _value.maxDays
          : maxDays // ignore: cast_nullable_to_non_nullable
              as int,
      requiresApproval: null == requiresApproval
          ? _value.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaid: null == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
      carryForward: null == carryForward
          ? _value.carryForward
          : carryForward // ignore: cast_nullable_to_non_nullable
              as bool,
      maxCarryForwardDays: null == maxCarryForwardDays
          ? _value.maxCarryForwardDays
          : maxCarryForwardDays // ignore: cast_nullable_to_non_nullable
              as int,
      requiresDocument: null == requiresDocument
          ? _value.requiresDocument
          : requiresDocument // ignore: cast_nullable_to_non_nullable
              as bool,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaveTypeModelImplCopyWith<$Res>
    implements $LeaveTypeModelCopyWith<$Res> {
  factory _$$LeaveTypeModelImplCopyWith(_$LeaveTypeModelImpl value,
          $Res Function(_$LeaveTypeModelImpl) then) =
      __$$LeaveTypeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      int defaultDays,
      int maxDays,
      bool requiresApproval,
      bool isPaid,
      bool carryForward,
      int maxCarryForwardDays,
      bool requiresDocument,
      String? color,
      String? icon,
      bool isActive,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$LeaveTypeModelImplCopyWithImpl<$Res>
    extends _$LeaveTypeModelCopyWithImpl<$Res, _$LeaveTypeModelImpl>
    implements _$$LeaveTypeModelImplCopyWith<$Res> {
  __$$LeaveTypeModelImplCopyWithImpl(
      _$LeaveTypeModelImpl _value, $Res Function(_$LeaveTypeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaveTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? defaultDays = null,
    Object? maxDays = null,
    Object? requiresApproval = null,
    Object? isPaid = null,
    Object? carryForward = null,
    Object? maxCarryForwardDays = null,
    Object? requiresDocument = null,
    Object? color = freezed,
    Object? icon = freezed,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$LeaveTypeModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultDays: null == defaultDays
          ? _value.defaultDays
          : defaultDays // ignore: cast_nullable_to_non_nullable
              as int,
      maxDays: null == maxDays
          ? _value.maxDays
          : maxDays // ignore: cast_nullable_to_non_nullable
              as int,
      requiresApproval: null == requiresApproval
          ? _value.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaid: null == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
      carryForward: null == carryForward
          ? _value.carryForward
          : carryForward // ignore: cast_nullable_to_non_nullable
              as bool,
      maxCarryForwardDays: null == maxCarryForwardDays
          ? _value.maxCarryForwardDays
          : maxCarryForwardDays // ignore: cast_nullable_to_non_nullable
              as int,
      requiresDocument: null == requiresDocument
          ? _value.requiresDocument
          : requiresDocument // ignore: cast_nullable_to_non_nullable
              as bool,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveTypeModelImpl extends _LeaveTypeModel {
  const _$LeaveTypeModelImpl(
      {required this.id,
      required this.name,
      this.description,
      required this.defaultDays,
      this.maxDays = 0,
      this.requiresApproval = false,
      this.isPaid = false,
      this.carryForward = false,
      this.maxCarryForwardDays = 0,
      this.requiresDocument = false,
      this.color,
      this.icon,
      this.isActive = true,
      required this.createdAt,
      this.updatedAt})
      : super._();

  factory _$LeaveTypeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveTypeModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final int defaultDays;
  @override
  @JsonKey()
  final int maxDays;
  @override
  @JsonKey()
  final bool requiresApproval;
  @override
  @JsonKey()
  final bool isPaid;
  @override
  @JsonKey()
  final bool carryForward;
  @override
  @JsonKey()
  final int maxCarryForwardDays;
  @override
  @JsonKey()
  final bool requiresDocument;
  @override
  final String? color;
  @override
  final String? icon;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'LeaveTypeModel(id: $id, name: $name, description: $description, defaultDays: $defaultDays, maxDays: $maxDays, requiresApproval: $requiresApproval, isPaid: $isPaid, carryForward: $carryForward, maxCarryForwardDays: $maxCarryForwardDays, requiresDocument: $requiresDocument, color: $color, icon: $icon, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveTypeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.defaultDays, defaultDays) ||
                other.defaultDays == defaultDays) &&
            (identical(other.maxDays, maxDays) || other.maxDays == maxDays) &&
            (identical(other.requiresApproval, requiresApproval) ||
                other.requiresApproval == requiresApproval) &&
            (identical(other.isPaid, isPaid) || other.isPaid == isPaid) &&
            (identical(other.carryForward, carryForward) ||
                other.carryForward == carryForward) &&
            (identical(other.maxCarryForwardDays, maxCarryForwardDays) ||
                other.maxCarryForwardDays == maxCarryForwardDays) &&
            (identical(other.requiresDocument, requiresDocument) ||
                other.requiresDocument == requiresDocument) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      defaultDays,
      maxDays,
      requiresApproval,
      isPaid,
      carryForward,
      maxCarryForwardDays,
      requiresDocument,
      color,
      icon,
      isActive,
      createdAt,
      updatedAt);

  /// Create a copy of LeaveTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveTypeModelImplCopyWith<_$LeaveTypeModelImpl> get copyWith =>
      __$$LeaveTypeModelImplCopyWithImpl<_$LeaveTypeModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveTypeModelImplToJson(
      this,
    );
  }
}

abstract class _LeaveTypeModel extends LeaveTypeModel {
  const factory _LeaveTypeModel(
      {required final String id,
      required final String name,
      final String? description,
      required final int defaultDays,
      final int maxDays,
      final bool requiresApproval,
      final bool isPaid,
      final bool carryForward,
      final int maxCarryForwardDays,
      final bool requiresDocument,
      final String? color,
      final String? icon,
      final bool isActive,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$LeaveTypeModelImpl;
  const _LeaveTypeModel._() : super._();

  factory _LeaveTypeModel.fromJson(Map<String, dynamic> json) =
      _$LeaveTypeModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  int get defaultDays;
  @override
  int get maxDays;
  @override
  bool get requiresApproval;
  @override
  bool get isPaid;
  @override
  bool get carryForward;
  @override
  int get maxCarryForwardDays;
  @override
  bool get requiresDocument;
  @override
  String? get color;
  @override
  String? get icon;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of LeaveTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveTypeModelImplCopyWith<_$LeaveTypeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
