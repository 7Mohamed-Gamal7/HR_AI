// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'holiday_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HolidayModel _$HolidayModelFromJson(Map<String, dynamic> json) {
  return _HolidayModel.fromJson(json);
}

/// @nodoc
mixin _$HolidayModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool get isPaid => throw _privateConstructorUsedError;
  bool get isRecurring => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this HolidayModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HolidayModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HolidayModelCopyWith<HolidayModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HolidayModelCopyWith<$Res> {
  factory $HolidayModelCopyWith(
          HolidayModel value, $Res Function(HolidayModel) then) =
      _$HolidayModelCopyWithImpl<$Res, HolidayModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      DateTime date,
      DateTime? endDate,
      bool isPaid,
      bool isRecurring,
      String? country,
      bool isActive,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$HolidayModelCopyWithImpl<$Res, $Val extends HolidayModel>
    implements $HolidayModelCopyWith<$Res> {
  _$HolidayModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HolidayModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? date = null,
    Object? endDate = freezed,
    Object? isPaid = null,
    Object? isRecurring = null,
    Object? country = freezed,
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
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isPaid: null == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
      isRecurring: null == isRecurring
          ? _value.isRecurring
          : isRecurring // ignore: cast_nullable_to_non_nullable
              as bool,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
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
abstract class _$$HolidayModelImplCopyWith<$Res>
    implements $HolidayModelCopyWith<$Res> {
  factory _$$HolidayModelImplCopyWith(
          _$HolidayModelImpl value, $Res Function(_$HolidayModelImpl) then) =
      __$$HolidayModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      DateTime date,
      DateTime? endDate,
      bool isPaid,
      bool isRecurring,
      String? country,
      bool isActive,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$HolidayModelImplCopyWithImpl<$Res>
    extends _$HolidayModelCopyWithImpl<$Res, _$HolidayModelImpl>
    implements _$$HolidayModelImplCopyWith<$Res> {
  __$$HolidayModelImplCopyWithImpl(
      _$HolidayModelImpl _value, $Res Function(_$HolidayModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of HolidayModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? date = null,
    Object? endDate = freezed,
    Object? isPaid = null,
    Object? isRecurring = null,
    Object? country = freezed,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$HolidayModelImpl(
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
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isPaid: null == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
      isRecurring: null == isRecurring
          ? _value.isRecurring
          : isRecurring // ignore: cast_nullable_to_non_nullable
              as bool,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
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
class _$HolidayModelImpl extends _HolidayModel {
  const _$HolidayModelImpl(
      {required this.id,
      required this.name,
      this.description,
      required this.date,
      this.endDate,
      this.isPaid = true,
      this.isRecurring = false,
      this.country,
      this.isActive = true,
      required this.createdAt,
      this.updatedAt})
      : super._();

  factory _$HolidayModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HolidayModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final DateTime date;
  @override
  final DateTime? endDate;
  @override
  @JsonKey()
  final bool isPaid;
  @override
  @JsonKey()
  final bool isRecurring;
  @override
  final String? country;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'HolidayModel(id: $id, name: $name, description: $description, date: $date, endDate: $endDate, isPaid: $isPaid, isRecurring: $isRecurring, country: $country, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HolidayModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isPaid, isPaid) || other.isPaid == isPaid) &&
            (identical(other.isRecurring, isRecurring) ||
                other.isRecurring == isRecurring) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, date,
      endDate, isPaid, isRecurring, country, isActive, createdAt, updatedAt);

  /// Create a copy of HolidayModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HolidayModelImplCopyWith<_$HolidayModelImpl> get copyWith =>
      __$$HolidayModelImplCopyWithImpl<_$HolidayModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HolidayModelImplToJson(
      this,
    );
  }
}

abstract class _HolidayModel extends HolidayModel {
  const factory _HolidayModel(
      {required final String id,
      required final String name,
      final String? description,
      required final DateTime date,
      final DateTime? endDate,
      final bool isPaid,
      final bool isRecurring,
      final String? country,
      final bool isActive,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$HolidayModelImpl;
  const _HolidayModel._() : super._();

  factory _HolidayModel.fromJson(Map<String, dynamic> json) =
      _$HolidayModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  DateTime get date;
  @override
  DateTime? get endDate;
  @override
  bool get isPaid;
  @override
  bool get isRecurring;
  @override
  String? get country;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of HolidayModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HolidayModelImplCopyWith<_$HolidayModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
