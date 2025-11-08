// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AttendanceModel _$AttendanceModelFromJson(Map<String, dynamic> json) {
  return _AttendanceModel.fromJson(json);
}

/// @nodoc
mixin _$AttendanceModel {
  String get id => throw _privateConstructorUsedError;
  String get employeeId => throw _privateConstructorUsedError;
  String? get employeeName => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  DateTime? get checkInTime => throw _privateConstructorUsedError;
  DateTime? get checkOutTime => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int? get workDuration => throw _privateConstructorUsedError;
  int? get lateDuration => throw _privateConstructorUsedError;
  int? get earlyDepartureDuration => throw _privateConstructorUsedError;
  int? get overtimeDuration => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get checkInMethod => throw _privateConstructorUsedError;
  String? get checkOutMethod => throw _privateConstructorUsedError;
  String? get checkInLocation => throw _privateConstructorUsedError;
  String? get checkOutLocation => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this AttendanceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceModelCopyWith<AttendanceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceModelCopyWith<$Res> {
  factory $AttendanceModelCopyWith(
          AttendanceModel value, $Res Function(AttendanceModel) then) =
      _$AttendanceModelCopyWithImpl<$Res, AttendanceModel>;
  @useResult
  $Res call(
      {String id,
      String employeeId,
      String? employeeName,
      DateTime date,
      DateTime? checkInTime,
      DateTime? checkOutTime,
      String status,
      int? workDuration,
      int? lateDuration,
      int? earlyDepartureDuration,
      int? overtimeDuration,
      String? notes,
      String? checkInMethod,
      String? checkOutMethod,
      String? checkInLocation,
      String? checkOutLocation,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$AttendanceModelCopyWithImpl<$Res, $Val extends AttendanceModel>
    implements $AttendanceModelCopyWith<$Res> {
  _$AttendanceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? employeeName = freezed,
    Object? date = null,
    Object? checkInTime = freezed,
    Object? checkOutTime = freezed,
    Object? status = null,
    Object? workDuration = freezed,
    Object? lateDuration = freezed,
    Object? earlyDepartureDuration = freezed,
    Object? overtimeDuration = freezed,
    Object? notes = freezed,
    Object? checkInMethod = freezed,
    Object? checkOutMethod = freezed,
    Object? checkInLocation = freezed,
    Object? checkOutLocation = freezed,
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
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      checkInTime: freezed == checkInTime
          ? _value.checkInTime
          : checkInTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      checkOutTime: freezed == checkOutTime
          ? _value.checkOutTime
          : checkOutTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      workDuration: freezed == workDuration
          ? _value.workDuration
          : workDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      lateDuration: freezed == lateDuration
          ? _value.lateDuration
          : lateDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      earlyDepartureDuration: freezed == earlyDepartureDuration
          ? _value.earlyDepartureDuration
          : earlyDepartureDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      overtimeDuration: freezed == overtimeDuration
          ? _value.overtimeDuration
          : overtimeDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      checkInMethod: freezed == checkInMethod
          ? _value.checkInMethod
          : checkInMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      checkOutMethod: freezed == checkOutMethod
          ? _value.checkOutMethod
          : checkOutMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      checkInLocation: freezed == checkInLocation
          ? _value.checkInLocation
          : checkInLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      checkOutLocation: freezed == checkOutLocation
          ? _value.checkOutLocation
          : checkOutLocation // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$AttendanceModelImplCopyWith<$Res>
    implements $AttendanceModelCopyWith<$Res> {
  factory _$$AttendanceModelImplCopyWith(_$AttendanceModelImpl value,
          $Res Function(_$AttendanceModelImpl) then) =
      __$$AttendanceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String employeeId,
      String? employeeName,
      DateTime date,
      DateTime? checkInTime,
      DateTime? checkOutTime,
      String status,
      int? workDuration,
      int? lateDuration,
      int? earlyDepartureDuration,
      int? overtimeDuration,
      String? notes,
      String? checkInMethod,
      String? checkOutMethod,
      String? checkInLocation,
      String? checkOutLocation,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$AttendanceModelImplCopyWithImpl<$Res>
    extends _$AttendanceModelCopyWithImpl<$Res, _$AttendanceModelImpl>
    implements _$$AttendanceModelImplCopyWith<$Res> {
  __$$AttendanceModelImplCopyWithImpl(
      _$AttendanceModelImpl _value, $Res Function(_$AttendanceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AttendanceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? employeeName = freezed,
    Object? date = null,
    Object? checkInTime = freezed,
    Object? checkOutTime = freezed,
    Object? status = null,
    Object? workDuration = freezed,
    Object? lateDuration = freezed,
    Object? earlyDepartureDuration = freezed,
    Object? overtimeDuration = freezed,
    Object? notes = freezed,
    Object? checkInMethod = freezed,
    Object? checkOutMethod = freezed,
    Object? checkInLocation = freezed,
    Object? checkOutLocation = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$AttendanceModelImpl(
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
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      checkInTime: freezed == checkInTime
          ? _value.checkInTime
          : checkInTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      checkOutTime: freezed == checkOutTime
          ? _value.checkOutTime
          : checkOutTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      workDuration: freezed == workDuration
          ? _value.workDuration
          : workDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      lateDuration: freezed == lateDuration
          ? _value.lateDuration
          : lateDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      earlyDepartureDuration: freezed == earlyDepartureDuration
          ? _value.earlyDepartureDuration
          : earlyDepartureDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      overtimeDuration: freezed == overtimeDuration
          ? _value.overtimeDuration
          : overtimeDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      checkInMethod: freezed == checkInMethod
          ? _value.checkInMethod
          : checkInMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      checkOutMethod: freezed == checkOutMethod
          ? _value.checkOutMethod
          : checkOutMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      checkInLocation: freezed == checkInLocation
          ? _value.checkInLocation
          : checkInLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      checkOutLocation: freezed == checkOutLocation
          ? _value.checkOutLocation
          : checkOutLocation // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$AttendanceModelImpl extends _AttendanceModel {
  const _$AttendanceModelImpl(
      {required this.id,
      required this.employeeId,
      this.employeeName,
      required this.date,
      this.checkInTime,
      this.checkOutTime,
      required this.status,
      this.workDuration,
      this.lateDuration,
      this.earlyDepartureDuration,
      this.overtimeDuration,
      this.notes,
      this.checkInMethod,
      this.checkOutMethod,
      this.checkInLocation,
      this.checkOutLocation,
      required this.createdAt,
      this.updatedAt})
      : super._();

  factory _$AttendanceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceModelImplFromJson(json);

  @override
  final String id;
  @override
  final String employeeId;
  @override
  final String? employeeName;
  @override
  final DateTime date;
  @override
  final DateTime? checkInTime;
  @override
  final DateTime? checkOutTime;
  @override
  final String status;
  @override
  final int? workDuration;
  @override
  final int? lateDuration;
  @override
  final int? earlyDepartureDuration;
  @override
  final int? overtimeDuration;
  @override
  final String? notes;
  @override
  final String? checkInMethod;
  @override
  final String? checkOutMethod;
  @override
  final String? checkInLocation;
  @override
  final String? checkOutLocation;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'AttendanceModel(id: $id, employeeId: $employeeId, employeeName: $employeeName, date: $date, checkInTime: $checkInTime, checkOutTime: $checkOutTime, status: $status, workDuration: $workDuration, lateDuration: $lateDuration, earlyDepartureDuration: $earlyDepartureDuration, overtimeDuration: $overtimeDuration, notes: $notes, checkInMethod: $checkInMethod, checkOutMethod: $checkOutMethod, checkInLocation: $checkInLocation, checkOutLocation: $checkOutLocation, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.checkInTime, checkInTime) ||
                other.checkInTime == checkInTime) &&
            (identical(other.checkOutTime, checkOutTime) ||
                other.checkOutTime == checkOutTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.workDuration, workDuration) ||
                other.workDuration == workDuration) &&
            (identical(other.lateDuration, lateDuration) ||
                other.lateDuration == lateDuration) &&
            (identical(other.earlyDepartureDuration, earlyDepartureDuration) ||
                other.earlyDepartureDuration == earlyDepartureDuration) &&
            (identical(other.overtimeDuration, overtimeDuration) ||
                other.overtimeDuration == overtimeDuration) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.checkInMethod, checkInMethod) ||
                other.checkInMethod == checkInMethod) &&
            (identical(other.checkOutMethod, checkOutMethod) ||
                other.checkOutMethod == checkOutMethod) &&
            (identical(other.checkInLocation, checkInLocation) ||
                other.checkInLocation == checkInLocation) &&
            (identical(other.checkOutLocation, checkOutLocation) ||
                other.checkOutLocation == checkOutLocation) &&
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
      date,
      checkInTime,
      checkOutTime,
      status,
      workDuration,
      lateDuration,
      earlyDepartureDuration,
      overtimeDuration,
      notes,
      checkInMethod,
      checkOutMethod,
      checkInLocation,
      checkOutLocation,
      createdAt,
      updatedAt);

  /// Create a copy of AttendanceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceModelImplCopyWith<_$AttendanceModelImpl> get copyWith =>
      __$$AttendanceModelImplCopyWithImpl<_$AttendanceModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceModelImplToJson(
      this,
    );
  }
}

abstract class _AttendanceModel extends AttendanceModel {
  const factory _AttendanceModel(
      {required final String id,
      required final String employeeId,
      final String? employeeName,
      required final DateTime date,
      final DateTime? checkInTime,
      final DateTime? checkOutTime,
      required final String status,
      final int? workDuration,
      final int? lateDuration,
      final int? earlyDepartureDuration,
      final int? overtimeDuration,
      final String? notes,
      final String? checkInMethod,
      final String? checkOutMethod,
      final String? checkInLocation,
      final String? checkOutLocation,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$AttendanceModelImpl;
  const _AttendanceModel._() : super._();

  factory _AttendanceModel.fromJson(Map<String, dynamic> json) =
      _$AttendanceModelImpl.fromJson;

  @override
  String get id;
  @override
  String get employeeId;
  @override
  String? get employeeName;
  @override
  DateTime get date;
  @override
  DateTime? get checkInTime;
  @override
  DateTime? get checkOutTime;
  @override
  String get status;
  @override
  int? get workDuration;
  @override
  int? get lateDuration;
  @override
  int? get earlyDepartureDuration;
  @override
  int? get overtimeDuration;
  @override
  String? get notes;
  @override
  String? get checkInMethod;
  @override
  String? get checkOutMethod;
  @override
  String? get checkInLocation;
  @override
  String? get checkOutLocation;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of AttendanceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceModelImplCopyWith<_$AttendanceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
