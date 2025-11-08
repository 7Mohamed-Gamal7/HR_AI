// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaveRequestModel _$LeaveRequestModelFromJson(Map<String, dynamic> json) {
  return _LeaveRequestModel.fromJson(json);
}

/// @nodoc
mixin _$LeaveRequestModel {
  String get id => throw _privateConstructorUsedError;
  String get employeeId => throw _privateConstructorUsedError;
  String? get employeeName => throw _privateConstructorUsedError;
  String get leaveTypeId => throw _privateConstructorUsedError;
  String? get leaveTypeName => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  int get numberOfDays => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  String? get rejectionReason => throw _privateConstructorUsedError;
  String? get approverId => throw _privateConstructorUsedError;
  String? get approverName => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  String? get documentPath => throw _privateConstructorUsedError;
  bool get isEmergency => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this LeaveRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveRequestModelCopyWith<LeaveRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveRequestModelCopyWith<$Res> {
  factory $LeaveRequestModelCopyWith(
          LeaveRequestModel value, $Res Function(LeaveRequestModel) then) =
      _$LeaveRequestModelCopyWithImpl<$Res, LeaveRequestModel>;
  @useResult
  $Res call(
      {String id,
      String employeeId,
      String? employeeName,
      String leaveTypeId,
      String? leaveTypeName,
      DateTime startDate,
      DateTime endDate,
      int numberOfDays,
      String status,
      String? reason,
      String? rejectionReason,
      String? approverId,
      String? approverName,
      DateTime? approvedAt,
      String? documentPath,
      bool isEmergency,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$LeaveRequestModelCopyWithImpl<$Res, $Val extends LeaveRequestModel>
    implements $LeaveRequestModelCopyWith<$Res> {
  _$LeaveRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? employeeName = freezed,
    Object? leaveTypeId = null,
    Object? leaveTypeName = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? numberOfDays = null,
    Object? status = null,
    Object? reason = freezed,
    Object? rejectionReason = freezed,
    Object? approverId = freezed,
    Object? approverName = freezed,
    Object? approvedAt = freezed,
    Object? documentPath = freezed,
    Object? isEmergency = null,
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
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      numberOfDays: null == numberOfDays
          ? _value.numberOfDays
          : numberOfDays // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      approverId: freezed == approverId
          ? _value.approverId
          : approverId // ignore: cast_nullable_to_non_nullable
              as String?,
      approverName: freezed == approverName
          ? _value.approverName
          : approverName // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      documentPath: freezed == documentPath
          ? _value.documentPath
          : documentPath // ignore: cast_nullable_to_non_nullable
              as String?,
      isEmergency: null == isEmergency
          ? _value.isEmergency
          : isEmergency // ignore: cast_nullable_to_non_nullable
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
abstract class _$$LeaveRequestModelImplCopyWith<$Res>
    implements $LeaveRequestModelCopyWith<$Res> {
  factory _$$LeaveRequestModelImplCopyWith(_$LeaveRequestModelImpl value,
          $Res Function(_$LeaveRequestModelImpl) then) =
      __$$LeaveRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String employeeId,
      String? employeeName,
      String leaveTypeId,
      String? leaveTypeName,
      DateTime startDate,
      DateTime endDate,
      int numberOfDays,
      String status,
      String? reason,
      String? rejectionReason,
      String? approverId,
      String? approverName,
      DateTime? approvedAt,
      String? documentPath,
      bool isEmergency,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$LeaveRequestModelImplCopyWithImpl<$Res>
    extends _$LeaveRequestModelCopyWithImpl<$Res, _$LeaveRequestModelImpl>
    implements _$$LeaveRequestModelImplCopyWith<$Res> {
  __$$LeaveRequestModelImplCopyWithImpl(_$LeaveRequestModelImpl _value,
      $Res Function(_$LeaveRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaveRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? employeeName = freezed,
    Object? leaveTypeId = null,
    Object? leaveTypeName = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? numberOfDays = null,
    Object? status = null,
    Object? reason = freezed,
    Object? rejectionReason = freezed,
    Object? approverId = freezed,
    Object? approverName = freezed,
    Object? approvedAt = freezed,
    Object? documentPath = freezed,
    Object? isEmergency = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$LeaveRequestModelImpl(
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
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      numberOfDays: null == numberOfDays
          ? _value.numberOfDays
          : numberOfDays // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      approverId: freezed == approverId
          ? _value.approverId
          : approverId // ignore: cast_nullable_to_non_nullable
              as String?,
      approverName: freezed == approverName
          ? _value.approverName
          : approverName // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      documentPath: freezed == documentPath
          ? _value.documentPath
          : documentPath // ignore: cast_nullable_to_non_nullable
              as String?,
      isEmergency: null == isEmergency
          ? _value.isEmergency
          : isEmergency // ignore: cast_nullable_to_non_nullable
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
class _$LeaveRequestModelImpl extends _LeaveRequestModel {
  const _$LeaveRequestModelImpl(
      {required this.id,
      required this.employeeId,
      this.employeeName,
      required this.leaveTypeId,
      this.leaveTypeName,
      required this.startDate,
      required this.endDate,
      required this.numberOfDays,
      required this.status,
      this.reason,
      this.rejectionReason,
      this.approverId,
      this.approverName,
      this.approvedAt,
      this.documentPath,
      this.isEmergency = false,
      required this.createdAt,
      this.updatedAt})
      : super._();

  factory _$LeaveRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveRequestModelImplFromJson(json);

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
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final int numberOfDays;
  @override
  final String status;
  @override
  final String? reason;
  @override
  final String? rejectionReason;
  @override
  final String? approverId;
  @override
  final String? approverName;
  @override
  final DateTime? approvedAt;
  @override
  final String? documentPath;
  @override
  @JsonKey()
  final bool isEmergency;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'LeaveRequestModel(id: $id, employeeId: $employeeId, employeeName: $employeeName, leaveTypeId: $leaveTypeId, leaveTypeName: $leaveTypeName, startDate: $startDate, endDate: $endDate, numberOfDays: $numberOfDays, status: $status, reason: $reason, rejectionReason: $rejectionReason, approverId: $approverId, approverName: $approverName, approvedAt: $approvedAt, documentPath: $documentPath, isEmergency: $isEmergency, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveRequestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.leaveTypeId, leaveTypeId) ||
                other.leaveTypeId == leaveTypeId) &&
            (identical(other.leaveTypeName, leaveTypeName) ||
                other.leaveTypeName == leaveTypeName) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.numberOfDays, numberOfDays) ||
                other.numberOfDays == numberOfDays) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            (identical(other.approverId, approverId) ||
                other.approverId == approverId) &&
            (identical(other.approverName, approverName) ||
                other.approverName == approverName) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.documentPath, documentPath) ||
                other.documentPath == documentPath) &&
            (identical(other.isEmergency, isEmergency) ||
                other.isEmergency == isEmergency) &&
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
      startDate,
      endDate,
      numberOfDays,
      status,
      reason,
      rejectionReason,
      approverId,
      approverName,
      approvedAt,
      documentPath,
      isEmergency,
      createdAt,
      updatedAt);

  /// Create a copy of LeaveRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveRequestModelImplCopyWith<_$LeaveRequestModelImpl> get copyWith =>
      __$$LeaveRequestModelImplCopyWithImpl<_$LeaveRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveRequestModelImplToJson(
      this,
    );
  }
}

abstract class _LeaveRequestModel extends LeaveRequestModel {
  const factory _LeaveRequestModel(
      {required final String id,
      required final String employeeId,
      final String? employeeName,
      required final String leaveTypeId,
      final String? leaveTypeName,
      required final DateTime startDate,
      required final DateTime endDate,
      required final int numberOfDays,
      required final String status,
      final String? reason,
      final String? rejectionReason,
      final String? approverId,
      final String? approverName,
      final DateTime? approvedAt,
      final String? documentPath,
      final bool isEmergency,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$LeaveRequestModelImpl;
  const _LeaveRequestModel._() : super._();

  factory _LeaveRequestModel.fromJson(Map<String, dynamic> json) =
      _$LeaveRequestModelImpl.fromJson;

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
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  int get numberOfDays;
  @override
  String get status;
  @override
  String? get reason;
  @override
  String? get rejectionReason;
  @override
  String? get approverId;
  @override
  String? get approverName;
  @override
  DateTime? get approvedAt;
  @override
  String? get documentPath;
  @override
  bool get isEmergency;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of LeaveRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveRequestModelImplCopyWith<_$LeaveRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
