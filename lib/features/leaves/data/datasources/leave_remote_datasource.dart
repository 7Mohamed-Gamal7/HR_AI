import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/leave_type_model.dart';
import '../models/leave_request_model.dart';
import '../models/leave_balance_model.dart';

/// Abstract interface for leave remote data source
abstract class LeaveRemoteDataSource {
  // Leave Type operations
  Future<List<LeaveTypeModel>> getLeaveTypes({bool? isActive});
  Future<LeaveTypeModel> getLeaveTypeById(String id);
  Future<LeaveTypeModel> createLeaveType(LeaveTypeModel leaveType);
  Future<LeaveTypeModel> updateLeaveType(LeaveTypeModel leaveType);
  Future<void> deleteLeaveType(String id);

  // Leave Request operations
  Future<List<LeaveRequestModel>> getLeaveRequests({
    String? employeeId,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    int? page,
    int? limit,
  });
  Future<LeaveRequestModel> getLeaveRequestById(String id);
  Future<LeaveRequestModel> createLeaveRequest(LeaveRequestModel request);
  Future<LeaveRequestModel> updateLeaveRequest(LeaveRequestModel request);
  Future<LeaveRequestModel> approveLeaveRequest({
    required String requestId,
    required String approverId,
    String? notes,
  });
  Future<LeaveRequestModel> rejectLeaveRequest({
    required String requestId,
    required String approverId,
    required String reason,
  });
  Future<LeaveRequestModel> cancelLeaveRequest(String requestId);
  Future<void> deleteLeaveRequest(String id);

  // Leave Balance operations
  Future<List<LeaveBalanceModel>> getLeaveBalances({
    required String employeeId,
    int? year,
  });
  Future<LeaveBalanceModel> getLeaveBalanceById(String id);
  Future<LeaveBalanceModel?> getLeaveBalanceByEmployeeAndType({
    required String employeeId,
    required String leaveTypeId,
    required int year,
  });
  Future<LeaveBalanceModel> updateLeaveBalance(LeaveBalanceModel balance);
  Future<List<LeaveBalanceModel>> initializeLeaveBalances({
    required String employeeId,
    required int year,
  });
}

/// Implementation of leave remote data source using API
@LazySingleton(as: LeaveRemoteDataSource)
class LeaveRemoteDataSourceImpl implements LeaveRemoteDataSource {
  final ApiClient _apiClient;

  LeaveRemoteDataSourceImpl(this._apiClient);

  // ==================== Leave Type Operations ====================

  @override
  Future<List<LeaveTypeModel>> getLeaveTypes({bool? isActive}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (isActive != null) {
        queryParams['isActive'] = isActive;
      }

      final response = await _apiClient.get(
        ApiConstants.leaveTypes,
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) => LeaveTypeModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException(
        message: 'Failed to get leave types from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<LeaveTypeModel> getLeaveTypeById(String id) async {
    try {
      final response = await _apiClient.get('${ApiConstants.leaveTypes}/$id');

      return LeaveTypeModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(
        message: 'Failed to get leave type from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<LeaveTypeModel> createLeaveType(LeaveTypeModel leaveType) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.leaveTypes,
        data: leaveType.toJson(),
      );

      return LeaveTypeModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(
        message: 'Failed to create leave type on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<LeaveTypeModel> updateLeaveType(LeaveTypeModel leaveType) async {
    try {
      final response = await _apiClient.put(
        '${ApiConstants.leaveTypes}/${leaveType.id}',
        data: leaveType.toJson(),
      );

      return LeaveTypeModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(
        message: 'Failed to update leave type on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteLeaveType(String id) async {
    try {
      await _apiClient.delete('${ApiConstants.leaveTypes}/$id');
    } catch (e) {
      throw ServerException(
        message: 'Failed to delete leave type from server: ${e.toString()}',
      );
    }
  }

  // ==================== Leave Request Operations ====================

  @override
  Future<List<LeaveRequestModel>> getLeaveRequests({
    String? employeeId,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    int? page,
    int? limit,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (employeeId != null) queryParams['employeeId'] = employeeId;
      if (status != null) queryParams['status'] = status;
      if (startDate != null) {
        queryParams['startDate'] = startDate.toIso8601String().split('T')[0];
      }
      if (endDate != null) {
        queryParams['endDate'] = endDate.toIso8601String().split('T')[0];
      }
      if (page != null) queryParams['page'] = page;
      if (limit != null) queryParams['limit'] = limit;

      final response = await _apiClient.get(
        ApiConstants.leaveRequests,
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map(
            (json) => LeaveRequestModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw ServerException(
        message: 'Failed to get leave requests from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<LeaveRequestModel> getLeaveRequestById(String id) async {
    try {
      final response = await _apiClient.get(
        '${ApiConstants.leaveRequests}/$id',
      );

      return LeaveRequestModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(
        message: 'Failed to get leave request from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<LeaveRequestModel> createLeaveRequest(
    LeaveRequestModel request,
  ) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.leaveRequests,
        data: request.toJson(),
      );

      return LeaveRequestModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(
        message: 'Failed to create leave request on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<LeaveRequestModel> updateLeaveRequest(
    LeaveRequestModel request,
  ) async {
    try {
      final response = await _apiClient.put(
        '${ApiConstants.leaveRequests}/${request.id}',
        data: request.toJson(),
      );

      return LeaveRequestModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(
        message: 'Failed to update leave request on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<LeaveRequestModel> approveLeaveRequest({
    required String requestId,
    required String approverId,
    String? notes,
  }) async {
    try {
      final response = await _apiClient.post(
        '${ApiConstants.leaveRequests}/$requestId/approve',
        data: {'approverId': approverId, if (notes != null) 'notes': notes},
      );

      return LeaveRequestModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(
        message: 'Failed to approve leave request on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<LeaveRequestModel> rejectLeaveRequest({
    required String requestId,
    required String approverId,
    required String reason,
  }) async {
    try {
      final response = await _apiClient.post(
        '${ApiConstants.leaveRequests}/$requestId/reject',
        data: {'approverId': approverId, 'reason': reason},
      );

      return LeaveRequestModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(
        message: 'Failed to reject leave request on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<LeaveRequestModel> cancelLeaveRequest(String requestId) async {
    try {
      final response = await _apiClient.post(
        '${ApiConstants.leaveRequests}/$requestId/cancel',
      );

      return LeaveRequestModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(
        message: 'Failed to cancel leave request on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteLeaveRequest(String id) async {
    try {
      await _apiClient.delete('${ApiConstants.leaveRequests}/$id');
    } catch (e) {
      throw ServerException(
        message: 'Failed to delete leave request from server: ${e.toString()}',
      );
    }
  }

  // ==================== Leave Balance Operations ====================

  @override
  Future<List<LeaveBalanceModel>> getLeaveBalances({
    required String employeeId,
    int? year,
  }) async {
    try {
      final queryParams = <String, dynamic>{'employeeId': employeeId};
      if (year != null) queryParams['year'] = year;

      final response = await _apiClient.get(
        ApiConstants.leaveBalances,
        queryParameters: queryParams,
      );

      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map(
            (json) => LeaveBalanceModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw ServerException(
        message: 'Failed to get leave balances from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<LeaveBalanceModel> getLeaveBalanceById(String id) async {
    try {
      final response = await _apiClient.get(
        '${ApiConstants.leaveBalances}/$id',
      );

      return LeaveBalanceModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(
        message: 'Failed to get leave balance from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<LeaveBalanceModel?> getLeaveBalanceByEmployeeAndType({
    required String employeeId,
    required String leaveTypeId,
    required int year,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'employeeId': employeeId,
        'leaveTypeId': leaveTypeId,
        'year': year,
      };

      final response = await _apiClient.get(
        '${ApiConstants.leaveBalances}/find',
        queryParameters: queryParams,
      );

      if (response.data == null) {
        return null;
      }

      return LeaveBalanceModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(
        message:
            'Failed to get leave balance by employee and type from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<LeaveBalanceModel> updateLeaveBalance(
    LeaveBalanceModel balance,
  ) async {
    try {
      final response = await _apiClient.put(
        '${ApiConstants.leaveBalances}/${balance.id}',
        data: balance.toJson(),
      );

      return LeaveBalanceModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(
        message: 'Failed to update leave balance on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<LeaveBalanceModel>> initializeLeaveBalances({
    required String employeeId,
    required int year,
  }) async {
    try {
      final response = await _apiClient.post(
        '${ApiConstants.leaveBalances}/initialize',
        data: {'employeeId': employeeId, 'year': year},
      );

      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map(
            (json) => LeaveBalanceModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw ServerException(
        message:
            'Failed to initialize leave balances on server: ${e.toString()}',
      );
    }
  }
}
