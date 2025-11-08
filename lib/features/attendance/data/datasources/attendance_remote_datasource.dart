import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/attendance_model.dart';
import '../models/attendance_rule_model.dart';
import '../models/holiday_model.dart';

/// Abstract interface for attendance remote data source
abstract class AttendanceRemoteDataSource {
  // Attendance operations
  Future<List<AttendanceModel>> getAttendances({
    String? employeeId,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    int? limit,
    int? offset,
  });

  Future<AttendanceModel> getAttendanceById(String id);
  Future<AttendanceModel?> getAttendanceByEmployeeAndDate(
    String employeeId,
    DateTime date,
  );
  Future<AttendanceModel> createAttendance(AttendanceModel attendance);
  Future<AttendanceModel> updateAttendance(AttendanceModel attendance);
  Future<void> deleteAttendance(String id);
  Future<AttendanceModel> checkIn(
    String employeeId, {
    String? method,
    String? location,
  });
  Future<AttendanceModel> checkOut(
    String attendanceId, {
    String? method,
    String? location,
  });

  // Attendance Rule operations
  Future<List<AttendanceRuleModel>> getAttendanceRules({bool? isActive});
  Future<AttendanceRuleModel> getAttendanceRuleById(String id);
  Future<AttendanceRuleModel?> getDefaultAttendanceRule();
  Future<AttendanceRuleModel?> getAttendanceRuleForEmployee(String employeeId);
  Future<AttendanceRuleModel?> getAttendanceRuleForDepartment(
    String departmentId,
  );
  Future<AttendanceRuleModel> createAttendanceRule(AttendanceRuleModel rule);
  Future<AttendanceRuleModel> updateAttendanceRule(AttendanceRuleModel rule);
  Future<void> deleteAttendanceRule(String id);

  // Holiday operations
  Future<List<HolidayModel>> getHolidays({
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
  });
  Future<HolidayModel> getHolidayById(String id);
  Future<bool> isHoliday(DateTime date);
  Future<HolidayModel> createHoliday(HolidayModel holiday);
  Future<HolidayModel> updateHoliday(HolidayModel holiday);
  Future<void> deleteHoliday(String id);
}

/// Implementation of attendance remote data source using API
@LazySingleton(as: AttendanceRemoteDataSource)
class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final ApiClient _apiClient;

  AttendanceRemoteDataSourceImpl(this._apiClient);

  // ==================== Attendance Operations ====================

  @override
  Future<List<AttendanceModel>> getAttendances({
    String? employeeId,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    int? limit,
    int? offset,
  }) async {
    try {
      final queryParams = <String, dynamic>{};

      if (employeeId != null) queryParams['employee_id'] = employeeId;
      if (startDate != null) {
        queryParams['start_date'] = startDate.toIso8601String().split('T')[0];
      }
      if (endDate != null) {
        queryParams['end_date'] = endDate.toIso8601String().split('T')[0];
      }
      if (status != null) queryParams['status'] = status;
      if (limit != null) queryParams['limit'] = limit;
      if (offset != null) queryParams['offset'] = offset;

      final response = await _apiClient.get(
        ApiEndpoints.attendance,
        queryParameters: queryParams,
      );

      final List<dynamic> data = response.data['data'] ?? response.data;
      return data.map((json) => AttendanceModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(
        message: 'Failed to get attendances from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<AttendanceModel> getAttendanceById(String id) async {
    try {
      final response = await _apiClient.get('${ApiEndpoints.attendance}/$id');
      final data = response.data['data'] ?? response.data;
      return AttendanceModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to get attendance from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<AttendanceModel?> getAttendanceByEmployeeAndDate(
    String employeeId,
    DateTime date,
  ) async {
    try {
      final dateString = date.toIso8601String().split('T')[0];
      final response = await _apiClient.get(
        '${ApiEndpoints.attendance}/employee/$employeeId/date/$dateString',
      );

      if (response.data == null) {
        return null;
      }

      final data = response.data['data'] ?? response.data;
      return AttendanceModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to get attendance from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<AttendanceModel> createAttendance(AttendanceModel attendance) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.attendance,
        data: attendance.toJson(),
      );
      final data = response.data['data'] ?? response.data;
      return AttendanceModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to create attendance on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<AttendanceModel> updateAttendance(AttendanceModel attendance) async {
    try {
      final response = await _apiClient.put(
        '${ApiEndpoints.attendance}/${attendance.id}',
        data: attendance.toJson(),
      );
      final data = response.data['data'] ?? response.data;
      return AttendanceModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to update attendance on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteAttendance(String id) async {
    try {
      await _apiClient.delete('${ApiEndpoints.attendance}/$id');
    } catch (e) {
      throw ServerException(
        message: 'Failed to delete attendance from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<AttendanceModel> checkIn(
    String employeeId, {
    String? method,
    String? location,
  }) async {
    try {
      final response = await _apiClient.post(
        '${ApiEndpoints.attendance}/check-in',
        data: {
          'employee_id': employeeId,
          'check_in_method': method,
          'check_in_location': location,
        },
      );
      final data = response.data['data'] ?? response.data;
      return AttendanceModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to check in on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<AttendanceModel> checkOut(
    String attendanceId, {
    String? method,
    String? location,
  }) async {
    try {
      final response = await _apiClient.post(
        '${ApiEndpoints.attendance}/check-out',
        data: {
          'attendance_id': attendanceId,
          'check_out_method': method,
          'check_out_location': location,
        },
      );
      final data = response.data['data'] ?? response.data;
      return AttendanceModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to check out on server: ${e.toString()}',
      );
    }
  }

  // ==================== Attendance Rule Operations ====================

  @override
  Future<List<AttendanceRuleModel>> getAttendanceRules({bool? isActive}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (isActive != null) queryParams['is_active'] = isActive;

      final response = await _apiClient.get(
        ApiEndpoints.attendanceRules,
        queryParameters: queryParams,
      );

      final List<dynamic> data = response.data['data'] ?? response.data;
      return data.map((json) => AttendanceRuleModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(
        message: 'Failed to get attendance rules from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<AttendanceRuleModel> getAttendanceRuleById(String id) async {
    try {
      final response = await _apiClient.get(
        '${ApiEndpoints.attendanceRules}/$id',
      );
      final data = response.data['data'] ?? response.data;
      return AttendanceRuleModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to get attendance rule from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<AttendanceRuleModel?> getDefaultAttendanceRule() async {
    try {
      final response = await _apiClient.get(
        '${ApiEndpoints.attendanceRules}/default',
      );

      if (response.data == null) {
        return null;
      }

      final data = response.data['data'] ?? response.data;
      return AttendanceRuleModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to get default attendance rule: ${e.toString()}',
      );
    }
  }

  @override
  Future<AttendanceRuleModel?> getAttendanceRuleForEmployee(
    String employeeId,
  ) async {
    try {
      final response = await _apiClient.get(
        '${ApiEndpoints.attendanceRules}/employee/$employeeId',
      );

      if (response.data == null) {
        return null;
      }

      final data = response.data['data'] ?? response.data;
      return AttendanceRuleModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to get attendance rule for employee: ${e.toString()}',
      );
    }
  }

  @override
  Future<AttendanceRuleModel?> getAttendanceRuleForDepartment(
    String departmentId,
  ) async {
    try {
      final response = await _apiClient.get(
        '${ApiEndpoints.attendanceRules}/department/$departmentId',
      );

      if (response.data == null) {
        return null;
      }

      final data = response.data['data'] ?? response.data;
      return AttendanceRuleModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message:
            'Failed to get attendance rule for department: ${e.toString()}',
      );
    }
  }

  @override
  Future<AttendanceRuleModel> createAttendanceRule(
    AttendanceRuleModel rule,
  ) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.attendanceRules,
        data: rule.toJson(),
      );
      final data = response.data['data'] ?? response.data;
      return AttendanceRuleModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to create attendance rule on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<AttendanceRuleModel> updateAttendanceRule(
    AttendanceRuleModel rule,
  ) async {
    try {
      final response = await _apiClient.put(
        '${ApiEndpoints.attendanceRules}/${rule.id}',
        data: rule.toJson(),
      );
      final data = response.data['data'] ?? response.data;
      return AttendanceRuleModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to update attendance rule on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteAttendanceRule(String id) async {
    try {
      await _apiClient.delete('${ApiEndpoints.attendanceRules}/$id');
    } catch (e) {
      throw ServerException(
        message:
            'Failed to delete attendance rule from server: ${e.toString()}',
      );
    }
  }

  // ==================== Holiday Operations ====================

  @override
  Future<List<HolidayModel>> getHolidays({
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
  }) async {
    try {
      final queryParams = <String, dynamic>{};

      if (startDate != null) {
        queryParams['start_date'] = startDate.toIso8601String().split('T')[0];
      }
      if (endDate != null) {
        queryParams['end_date'] = endDate.toIso8601String().split('T')[0];
      }
      if (isActive != null) queryParams['is_active'] = isActive;

      final response = await _apiClient.get(
        ApiEndpoints.holidays,
        queryParameters: queryParams,
      );

      final List<dynamic> data = response.data['data'] ?? response.data;
      return data.map((json) => HolidayModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(
        message: 'Failed to get holidays from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<HolidayModel> getHolidayById(String id) async {
    try {
      final response = await _apiClient.get('${ApiEndpoints.holidays}/$id');
      final data = response.data['data'] ?? response.data;
      return HolidayModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to get holiday from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<bool> isHoliday(DateTime date) async {
    try {
      final dateString = date.toIso8601String().split('T')[0];
      final response = await _apiClient.get(
        '${ApiEndpoints.holidays}/check/$dateString',
      );
      final data = response.data['data'] ?? response.data;
      return data['is_holiday'] as bool? ?? false;
    } catch (e) {
      throw ServerException(
        message: 'Failed to check if date is holiday: ${e.toString()}',
      );
    }
  }

  @override
  Future<HolidayModel> createHoliday(HolidayModel holiday) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.holidays,
        data: holiday.toJson(),
      );
      final data = response.data['data'] ?? response.data;
      return HolidayModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to create holiday on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<HolidayModel> updateHoliday(HolidayModel holiday) async {
    try {
      final response = await _apiClient.put(
        '${ApiEndpoints.holidays}/${holiday.id}',
        data: holiday.toJson(),
      );
      final data = response.data['data'] ?? response.data;
      return HolidayModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to update holiday on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteHoliday(String id) async {
    try {
      await _apiClient.delete('${ApiEndpoints.holidays}/$id');
    } catch (e) {
      throw ServerException(
        message: 'Failed to delete holiday from server: ${e.toString()}',
      );
    }
  }
}
