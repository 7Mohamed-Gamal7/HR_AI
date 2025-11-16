// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_rule_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AttendanceRuleModel _$AttendanceRuleModelFromJson(Map<String, dynamic> json) {
  return _AttendanceRuleModel.fromJson(json);
}

/// @nodoc
mixin _$AttendanceRuleModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<int> get workDays => throw _privateConstructorUsedError;
  String get workStartTime => throw _privateConstructorUsedError;
  String get workEndTime => throw _privateConstructorUsedError;
  int get workHoursPerDay => throw _privateConstructorUsedError;
  int get lateMinutesAllowed => throw _privateConstructorUsedError;
  int get earlyDepartureMinutesAllowed => throw _privateConstructorUsedError;
  int get graceMinutes => throw _privateConstructorUsedError;
  bool get overtimeEnabled => throw _privateConstructorUsedError;
  int get overtimeStartAfterMinutes => throw _privateConstructorUsedError;
  double get overtimeMultiplier => throw _privateConstructorUsedError;
  bool get breakRequired => throw _privateConstructorUsedError;
  int get breakDurationMinutes => throw _privateConstructorUsedError;
  bool get breakPaid => throw _privateConstructorUsedError;
  String? get departmentId => throw _privateConstructorUsedError;
  String? get employeeId => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this AttendanceRuleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceRuleModelCopyWith<AttendanceRuleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceRuleModelCopyWith<$Res> {
  factory $AttendanceRuleModelCopyWith(
          AttendanceRuleModel value, $Res Function(AttendanceRuleModel) then) =
      _$AttendanceRuleModelCopyWithImpl<$Res, AttendanceRuleModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      List<int> workDays,
      String workStartTime,
      String workEndTime,
      int workHoursPerDay,
      int lateMinutesAllowed,
      int earlyDepartureMinutesAllowed,
      int graceMinutes,
      bool overtimeEnabled,
      int overtimeStartAfterMinutes,
      double overtimeMultiplier,
      bool breakRequired,
      int breakDurationMinutes,
      bool breakPaid,
      String? departmentId,
      String? employeeId,
      bool isDefault,
      bool isActive,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$AttendanceRuleModelCopyWithImpl<$Res, $Val extends AttendanceRuleModel>
    implements $AttendanceRuleModelCopyWith<$Res> {
  _$AttendanceRuleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? workDays = null,
    Object? workStartTime = null,
    Object? workEndTime = null,
    Object? workHoursPerDay = null,
    Object? lateMinutesAllowed = null,
    Object? earlyDepartureMinutesAllowed = null,
    Object? graceMinutes = null,
    Object? overtimeEnabled = null,
    Object? overtimeStartAfterMinutes = null,
    Object? overtimeMultiplier = null,
    Object? breakRequired = null,
    Object? breakDurationMinutes = null,
    Object? breakPaid = null,
    Object? departmentId = freezed,
    Object? employeeId = freezed,
    Object? isDefault = null,
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
      workDays: null == workDays
          ? _value.workDays
          : workDays // ignore: cast_nullable_to_non_nullable
              as List<int>,
      workStartTime: null == workStartTime
          ? _value.workStartTime
          : workStartTime // ignore: cast_nullable_to_non_nullable
              as String,
      workEndTime: null == workEndTime
          ? _value.workEndTime
          : workEndTime // ignore: cast_nullable_to_non_nullable
              as String,
      workHoursPerDay: null == workHoursPerDay
          ? _value.workHoursPerDay
          : workHoursPerDay // ignore: cast_nullable_to_non_nullable
              as int,
      lateMinutesAllowed: null == lateMinutesAllowed
          ? _value.lateMinutesAllowed
          : lateMinutesAllowed // ignore: cast_nullable_to_non_nullable
              as int,
      earlyDepartureMinutesAllowed: null == earlyDepartureMinutesAllowed
          ? _value.earlyDepartureMinutesAllowed
          : earlyDepartureMinutesAllowed // ignore: cast_nullable_to_non_nullable
              as int,
      graceMinutes: null == graceMinutes
          ? _value.graceMinutes
          : graceMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      overtimeEnabled: null == overtimeEnabled
          ? _value.overtimeEnabled
          : overtimeEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      overtimeStartAfterMinutes: null == overtimeStartAfterMinutes
          ? _value.overtimeStartAfterMinutes
          : overtimeStartAfterMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      overtimeMultiplier: null == overtimeMultiplier
          ? _value.overtimeMultiplier
          : overtimeMultiplier // ignore: cast_nullable_to_non_nullable
              as double,
      breakRequired: null == breakRequired
          ? _value.breakRequired
          : breakRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      breakDurationMinutes: null == breakDurationMinutes
          ? _value.breakDurationMinutes
          : breakDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      breakPaid: null == breakPaid
          ? _value.breakPaid
          : breakPaid // ignore: cast_nullable_to_non_nullable
              as bool,
      departmentId: freezed == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      employeeId: freezed == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$AttendanceRuleModelImplCopyWith<$Res>
    implements $AttendanceRuleModelCopyWith<$Res> {
  factory _$$AttendanceRuleModelImplCopyWith(_$AttendanceRuleModelImpl value,
          $Res Function(_$AttendanceRuleModelImpl) then) =
      __$$AttendanceRuleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      List<int> workDays,
      String workStartTime,
      String workEndTime,
      int workHoursPerDay,
      int lateMinutesAllowed,
      int earlyDepartureMinutesAllowed,
      int graceMinutes,
      bool overtimeEnabled,
      int overtimeStartAfterMinutes,
      double overtimeMultiplier,
      bool breakRequired,
      int breakDurationMinutes,
      bool breakPaid,
      String? departmentId,
      String? employeeId,
      bool isDefault,
      bool isActive,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$AttendanceRuleModelImplCopyWithImpl<$Res>
    extends _$AttendanceRuleModelCopyWithImpl<$Res, _$AttendanceRuleModelImpl>
    implements _$$AttendanceRuleModelImplCopyWith<$Res> {
  __$$AttendanceRuleModelImplCopyWithImpl(_$AttendanceRuleModelImpl _value,
      $Res Function(_$AttendanceRuleModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AttendanceRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? workDays = null,
    Object? workStartTime = null,
    Object? workEndTime = null,
    Object? workHoursPerDay = null,
    Object? lateMinutesAllowed = null,
    Object? earlyDepartureMinutesAllowed = null,
    Object? graceMinutes = null,
    Object? overtimeEnabled = null,
    Object? overtimeStartAfterMinutes = null,
    Object? overtimeMultiplier = null,
    Object? breakRequired = null,
    Object? breakDurationMinutes = null,
    Object? breakPaid = null,
    Object? departmentId = freezed,
    Object? employeeId = freezed,
    Object? isDefault = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$AttendanceRuleModelImpl(
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
      workDays: null == workDays
          ? _value._workDays
          : workDays // ignore: cast_nullable_to_non_nullable
              as List<int>,
      workStartTime: null == workStartTime
          ? _value.workStartTime
          : workStartTime // ignore: cast_nullable_to_non_nullable
              as String,
      workEndTime: null == workEndTime
          ? _value.workEndTime
          : workEndTime // ignore: cast_nullable_to_non_nullable
              as String,
      workHoursPerDay: null == workHoursPerDay
          ? _value.workHoursPerDay
          : workHoursPerDay // ignore: cast_nullable_to_non_nullable
              as int,
      lateMinutesAllowed: null == lateMinutesAllowed
          ? _value.lateMinutesAllowed
          : lateMinutesAllowed // ignore: cast_nullable_to_non_nullable
              as int,
      earlyDepartureMinutesAllowed: null == earlyDepartureMinutesAllowed
          ? _value.earlyDepartureMinutesAllowed
          : earlyDepartureMinutesAllowed // ignore: cast_nullable_to_non_nullable
              as int,
      graceMinutes: null == graceMinutes
          ? _value.graceMinutes
          : graceMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      overtimeEnabled: null == overtimeEnabled
          ? _value.overtimeEnabled
          : overtimeEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      overtimeStartAfterMinutes: null == overtimeStartAfterMinutes
          ? _value.overtimeStartAfterMinutes
          : overtimeStartAfterMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      overtimeMultiplier: null == overtimeMultiplier
          ? _value.overtimeMultiplier
          : overtimeMultiplier // ignore: cast_nullable_to_non_nullable
              as double,
      breakRequired: null == breakRequired
          ? _value.breakRequired
          : breakRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      breakDurationMinutes: null == breakDurationMinutes
          ? _value.breakDurationMinutes
          : breakDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      breakPaid: null == breakPaid
          ? _value.breakPaid
          : breakPaid // ignore: cast_nullable_to_non_nullable
              as bool,
      departmentId: freezed == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      employeeId: freezed == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$AttendanceRuleModelImpl extends _AttendanceRuleModel {
  const _$AttendanceRuleModelImpl(
      {required this.id,
      required this.name,
      this.description,
      required final List<int> workDays,
      required this.workStartTime,
      required this.workEndTime,
      required this.workHoursPerDay,
      this.lateMinutesAllowed = 15,
      this.earlyDepartureMinutesAllowed = 15,
      this.graceMinutes = 5,
      this.overtimeEnabled = true,
      this.overtimeStartAfterMinutes = 0,
      this.overtimeMultiplier = 1.5,
      this.breakRequired = true,
      this.breakDurationMinutes = 60,
      this.breakPaid = false,
      this.departmentId,
      this.employeeId,
      this.isDefault = false,
      this.isActive = true,
      required this.createdAt,
      this.updatedAt})
      : _workDays = workDays,
        super._();

  factory _$AttendanceRuleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceRuleModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  final List<int> _workDays;
  @override
  List<int> get workDays {
    if (_workDays is EqualUnmodifiableListView) return _workDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workDays);
  }

  @override
  final String workStartTime;
  @override
  final String workEndTime;
  @override
  final int workHoursPerDay;
  @override
  @JsonKey()
  final int lateMinutesAllowed;
  @override
  @JsonKey()
  final int earlyDepartureMinutesAllowed;
  @override
  @JsonKey()
  final int graceMinutes;
  @override
  @JsonKey()
  final bool overtimeEnabled;
  @override
  @JsonKey()
  final int overtimeStartAfterMinutes;
  @override
  @JsonKey()
  final double overtimeMultiplier;
  @override
  @JsonKey()
  final bool breakRequired;
  @override
  @JsonKey()
  final int breakDurationMinutes;
  @override
  @JsonKey()
  final bool breakPaid;
  @override
  final String? departmentId;
  @override
  final String? employeeId;
  @override
  @JsonKey()
  final bool isDefault;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'AttendanceRuleModel(id: $id, name: $name, description: $description, workDays: $workDays, workStartTime: $workStartTime, workEndTime: $workEndTime, workHoursPerDay: $workHoursPerDay, lateMinutesAllowed: $lateMinutesAllowed, earlyDepartureMinutesAllowed: $earlyDepartureMinutesAllowed, graceMinutes: $graceMinutes, overtimeEnabled: $overtimeEnabled, overtimeStartAfterMinutes: $overtimeStartAfterMinutes, overtimeMultiplier: $overtimeMultiplier, breakRequired: $breakRequired, breakDurationMinutes: $breakDurationMinutes, breakPaid: $breakPaid, departmentId: $departmentId, employeeId: $employeeId, isDefault: $isDefault, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceRuleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._workDays, _workDays) &&
            (identical(other.workStartTime, workStartTime) ||
                other.workStartTime == workStartTime) &&
            (identical(other.workEndTime, workEndTime) ||
                other.workEndTime == workEndTime) &&
            (identical(other.workHoursPerDay, workHoursPerDay) ||
                other.workHoursPerDay == workHoursPerDay) &&
            (identical(other.lateMinutesAllowed, lateMinutesAllowed) ||
                other.lateMinutesAllowed == lateMinutesAllowed) &&
            (identical(other.earlyDepartureMinutesAllowed,
                    earlyDepartureMinutesAllowed) ||
                other.earlyDepartureMinutesAllowed ==
                    earlyDepartureMinutesAllowed) &&
            (identical(other.graceMinutes, graceMinutes) ||
                other.graceMinutes == graceMinutes) &&
            (identical(other.overtimeEnabled, overtimeEnabled) ||
                other.overtimeEnabled == overtimeEnabled) &&
            (identical(other.overtimeStartAfterMinutes,
                    overtimeStartAfterMinutes) ||
                other.overtimeStartAfterMinutes == overtimeStartAfterMinutes) &&
            (identical(other.overtimeMultiplier, overtimeMultiplier) ||
                other.overtimeMultiplier == overtimeMultiplier) &&
            (identical(other.breakRequired, breakRequired) ||
                other.breakRequired == breakRequired) &&
            (identical(other.breakDurationMinutes, breakDurationMinutes) ||
                other.breakDurationMinutes == breakDurationMinutes) &&
            (identical(other.breakPaid, breakPaid) ||
                other.breakPaid == breakPaid) &&
            (identical(other.departmentId, departmentId) ||
                other.departmentId == departmentId) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        description,
        const DeepCollectionEquality().hash(_workDays),
        workStartTime,
        workEndTime,
        workHoursPerDay,
        lateMinutesAllowed,
        earlyDepartureMinutesAllowed,
        graceMinutes,
        overtimeEnabled,
        overtimeStartAfterMinutes,
        overtimeMultiplier,
        breakRequired,
        breakDurationMinutes,
        breakPaid,
        departmentId,
        employeeId,
        isDefault,
        isActive,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of AttendanceRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceRuleModelImplCopyWith<_$AttendanceRuleModelImpl> get copyWith =>
      __$$AttendanceRuleModelImplCopyWithImpl<_$AttendanceRuleModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceRuleModelImplToJson(
      this,
    );
  }
}

abstract class _AttendanceRuleModel extends AttendanceRuleModel {
  const factory _AttendanceRuleModel(
      {required final String id,
      required final String name,
      final String? description,
      required final List<int> workDays,
      required final String workStartTime,
      required final String workEndTime,
      required final int workHoursPerDay,
      final int lateMinutesAllowed,
      final int earlyDepartureMinutesAllowed,
      final int graceMinutes,
      final bool overtimeEnabled,
      final int overtimeStartAfterMinutes,
      final double overtimeMultiplier,
      final bool breakRequired,
      final int breakDurationMinutes,
      final bool breakPaid,
      final String? departmentId,
      final String? employeeId,
      final bool isDefault,
      final bool isActive,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$AttendanceRuleModelImpl;
  const _AttendanceRuleModel._() : super._();

  factory _AttendanceRuleModel.fromJson(Map<String, dynamic> json) =
      _$AttendanceRuleModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  List<int> get workDays;
  @override
  String get workStartTime;
  @override
  String get workEndTime;
  @override
  int get workHoursPerDay;
  @override
  int get lateMinutesAllowed;
  @override
  int get earlyDepartureMinutesAllowed;
  @override
  int get graceMinutes;
  @override
  bool get overtimeEnabled;
  @override
  int get overtimeStartAfterMinutes;
  @override
  double get overtimeMultiplier;
  @override
  bool get breakRequired;
  @override
  int get breakDurationMinutes;
  @override
  bool get breakPaid;
  @override
  String? get departmentId;
  @override
  String? get employeeId;
  @override
  bool get isDefault;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of AttendanceRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceRuleModelImplCopyWith<_$AttendanceRuleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
