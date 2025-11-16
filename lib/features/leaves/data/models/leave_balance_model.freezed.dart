// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_balance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaveBalanceModel _$LeaveBalanceModelFromJson(Map<String, dynamic> json) {
  return _LeaveBalanceModel.fromJson(json);
}

/// @nodoc
mixin _$LeaveBalanceModel {
  String get id => throw _privateConstructorUsedError;
  String get employeeId => throw _privateConstructorUsedError;
  String? get employeeName => throw _privateConstructorUsedError;
  String get leaveTypeId => throw _privateConstructorUsedError;
  String? get leaveTypeName => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  int get totalDays => throw _privateConstructorUsedError;
  int get usedDays => throw _privateConstructorUsedError;
  int get pendingDays => throw _privateConstructorUsedError;
  int get remainingDays => throw _privateConstructorUsedError;
  int get carriedForwardDays => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this LeaveBalanceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveBalanceModelCopyWith<LeaveBalanceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveBalanceModelCopyWith<$Res> {
  factory $LeaveBalanceModelCopyWith(
          LeaveBalanceModel value, $Res Function(LeaveBalanceModel) then) =
      _$LeaveBalanceModelCopyWithImpl<$Res, LeaveBalanceModel>;
  @useResult
  $Res call(
      {String id,
      String employeeId,
      String? employeeName,
      String leaveTypeId,
      String? leaveTypeName,
      int year,
      int totalDays,
      int usedDays,
      int pendingDays,
      int remainingDays,
      int carriedForwardDays,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$LeaveBalanceModelCopyWithImpl<$Res, $Val extends LeaveBalanceModel>
    implements $LeaveBalanceModelCopyWith<$Res> {
  _$LeaveBalanceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? employeeName = freezed,
    Object? leaveTypeId = null,
    Object? leaveTypeName = freezed,
    Object? year = null,
    Object? totalDays = null,
    Object? usedDays = null,
    Object? pendingDays = null,
    Object? remainingDays = null,
    Object? carriedForwardDays = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: freezed == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String?,
      leaveTypeId: null == leaveTypeId
          ? _value.leaveTypeId
          : leaveTypeId // ignore: cast_nullable_to_non_nullable
              as String,
      leaveTypeName: freezed == leaveTypeName
          ? _value.leaveTypeName
          : leaveTypeName // ignore: cast_nullable_to_non_nullable
              as String?,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      totalDays: null == totalDays
          ? _value.totalDays
          : totalDays // ignore: cast_nullable_to_non_nullable
              as int,
      usedDays: null == usedDays
          ? _value.usedDays
          : usedDays // ignore: cast_nullable_to_non_nullable
              as int,
      pendingDays: null == pendingDays
          ? _value.pendingDays
          : pendingDays // ignore: cast_nullable_to_non_nullable
              as int,
      remainingDays: null == remainingDays
          ? _value.remainingDays
          : remainingDays // ignore: cast_nullable_to_non_nullable
              as int,
      carriedForwardDays: null == carriedForwardDays
          ? _value.carriedForwardDays
          : carriedForwardDays // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$LeaveBalanceModelImplCopyWith<$Res>
    implements $LeaveBalanceModelCopyWith<$Res> {
  factory _$$LeaveBalanceModelImplCopyWith(_$LeaveBalanceModelImpl value,
          $Res Function(_$LeaveBalanceModelImpl) then) =
      __$$LeaveBalanceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String employeeId,
      String? employeeName,
      String leaveTypeId,
      String? leaveTypeName,
      int year,
      int totalDays,
      int usedDays,
      int pendingDays,
      int remainingDays,
      int carriedForwardDays,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$LeaveBalanceModelImplCopyWithImpl<$Res>
    extends _$LeaveBalanceModelCopyWithImpl<$Res, _$LeaveBalanceModelImpl>
    implements _$$LeaveBalanceModelImplCopyWith<$Res> {
  __$$LeaveBalanceModelImplCopyWithImpl(_$LeaveBalanceModelImpl _value,
      $Res Function(_$LeaveBalanceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaveBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? employeeName = freezed,
    Object? leaveTypeId = null,
    Object? leaveTypeName = freezed,
    Object? year = null,
    Object? totalDays = null,
    Object? usedDays = null,
    Object? pendingDays = null,
    Object? remainingDays = null,
    Object? carriedForwardDays = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$LeaveBalanceModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: freezed == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String?,
      leaveTypeId: null == leaveTypeId
          ? _value.leaveTypeId
          : leaveTypeId // ignore: cast_nullable_to_non_nullable
              as String,
      leaveTypeName: freezed == leaveTypeName
          ? _value.leaveTypeName
          : leaveTypeName // ignore: cast_nullable_to_non_nullable
              as String?,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      totalDays: null == totalDays
          ? _value.totalDays
          : totalDays // ignore: cast_nullable_to_non_nullable
              as int,
      usedDays: null == usedDays
          ? _value.usedDays
          : usedDays // ignore: cast_nullable_to_non_nullable
              as int,
      pendingDays: null == pendingDays
          ? _value.pendingDays
          : pendingDays // ignore: cast_nullable_to_non_nullable
              as int,
      remainingDays: null == remainingDays
          ? _value.remainingDays
          : remainingDays // ignore: cast_nullable_to_non_nullable
              as int,
      carriedForwardDays: null == carriedForwardDays
          ? _value.carriedForwardDays
          : carriedForwardDays // ignore: cast_nullable_to_non_nullable
              as int,
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
class _$LeaveBalanceModelImpl extends _LeaveBalanceModel {
  const _$LeaveBalanceModelImpl(
      {required this.id,
      required this.employeeId,
      this.employeeName,
      required this.leaveTypeId,
      this.leaveTypeName,
      required this.year,
      required this.totalDays,
      this.usedDays = 0,
      this.pendingDays = 0,
      this.remainingDays = 0,
      this.carriedForwardDays = 0,
      required this.createdAt,
      this.updatedAt})
      : super._();

  factory _$LeaveBalanceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveBalanceModelImplFromJson(json);

  @override
  final String id;
  @override
  final String employeeId;
  @override
  final String? employeeName;
  @override
  final String leaveTypeId;
  @override
  final String? leaveTypeName;
  @override
  final int year;
  @override
  final int totalDays;
  @override
  @JsonKey()
  final int usedDays;
  @override
  @JsonKey()
  final int pendingDays;
  @override
  @JsonKey()
  final int remainingDays;
  @override
  @JsonKey()
  final int carriedForwardDays;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'LeaveBalanceModel(id: $id, employeeId: $employeeId, employeeName: $employeeName, leaveTypeId: $leaveTypeId, leaveTypeName: $leaveTypeName, year: $year, totalDays: $totalDays, usedDays: $usedDays, pendingDays: $pendingDays, remainingDays: $remainingDays, carriedForwardDays: $carriedForwardDays, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveBalanceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.leaveTypeId, leaveTypeId) ||
                other.leaveTypeId == leaveTypeId) &&
            (identical(other.leaveTypeName, leaveTypeName) ||
                other.leaveTypeName == leaveTypeName) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.totalDays, totalDays) ||
                other.totalDays == totalDays) &&
            (identical(other.usedDays, usedDays) ||
                other.usedDays == usedDays) &&
            (identical(other.pendingDays, pendingDays) ||
                other.pendingDays == pendingDays) &&
            (identical(other.remainingDays, remainingDays) ||
                other.remainingDays == remainingDays) &&
            (identical(other.carriedForwardDays, carriedForwardDays) ||
                other.carriedForwardDays == carriedForwardDays) &&
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
      employeeId,
      employeeName,
      leaveTypeId,
      leaveTypeName,
      year,
      totalDays,
      usedDays,
      pendingDays,
      remainingDays,
      carriedForwardDays,
      createdAt,
      updatedAt);

  /// Create a copy of LeaveBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveBalanceModelImplCopyWith<_$LeaveBalanceModelImpl> get copyWith =>
      __$$LeaveBalanceModelImplCopyWithImpl<_$LeaveBalanceModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveBalanceModelImplToJson(
      this,
    );
  }
}

abstract class _LeaveBalanceModel extends LeaveBalanceModel {
  const factory _LeaveBalanceModel(
      {required final String id,
      required final String employeeId,
      final String? employeeName,
      required final String leaveTypeId,
      final String? leaveTypeName,
      required final int year,
      required final int totalDays,
      final int usedDays,
      final int pendingDays,
      final int remainingDays,
      final int carriedForwardDays,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$LeaveBalanceModelImpl;
  const _LeaveBalanceModel._() : super._();

  factory _LeaveBalanceModel.fromJson(Map<String, dynamic> json) =
      _$LeaveBalanceModelImpl.fromJson;

  @override
  String get id;
  @override
  String get employeeId;
  @override
  String? get employeeName;
  @override
  String get leaveTypeId;
  @override
  String? get leaveTypeName;
  @override
  int get year;
  @override
  int get totalDays;
  @override
  int get usedDays;
  @override
  int get pendingDays;
  @override
  int get remainingDays;
  @override
  int get carriedForwardDays;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of LeaveBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveBalanceModelImplCopyWith<_$LeaveBalanceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
