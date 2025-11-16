import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/department_model.dart';
import '../models/employee_model.dart';
import '../models/position_model.dart';

/// Abstract interface for employee remote data source
abstract class EmployeeRemoteDataSource {
  // Employee operations
  Future<List<EmployeeModel>> getEmployees({
    String? departmentId,
    String? positionId,
    String? status,
    int? limit,
    int? offset,
  });

  Future<EmployeeModel> getEmployeeById(String id);
  Future<EmployeeModel> getEmployeeByCode(String code);
  Future<EmployeeModel> createEmployee(EmployeeModel employee);
  Future<EmployeeModel> updateEmployee(EmployeeModel employee);
  Future<void> deleteEmployee(String id);

  // Department operations
  Future<List<DepartmentModel>> getDepartments({bool? isActive});
  Future<DepartmentModel> getDepartmentById(String id);
  Future<DepartmentModel> createDepartment(DepartmentModel department);
  Future<DepartmentModel> updateDepartment(DepartmentModel department);
  Future<void> deleteDepartment(String id);

  // Position operations
  Future<List<PositionModel>> getPositions({
    String? departmentId,
    bool? isActive,
  });
  Future<PositionModel> getPositionById(String id);
  Future<PositionModel> createPosition(PositionModel position);
  Future<PositionModel> updatePosition(PositionModel position);
  Future<void> deletePosition(String id);
}

/// Implementation of employee remote data source using API
@LazySingleton(as: EmployeeRemoteDataSource)
class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  final ApiClient _apiClient;

  EmployeeRemoteDataSourceImpl(this._apiClient);

  // ==================== Employee Operations ====================

  @override
  Future<List<EmployeeModel>> getEmployees({
    String? departmentId,
    String? positionId,
    String? status,
    int? limit,
    int? offset,
  }) async {
    try {
      final queryParams = <String, dynamic>{};

      if (departmentId != null) queryParams['department_id'] = departmentId;
      if (positionId != null) queryParams['position_id'] = positionId;
      if (status != null) queryParams['status'] = status;
      if (limit != null) queryParams['limit'] = limit;
      if (offset != null) queryParams['offset'] = offset;

      final response = await _apiClient.get(
        ApiEndpoints.employees,
        queryParameters: queryParams,
      );

      final List<dynamic> data = response.data['data'] ?? response.data;
      return data.map((json) => EmployeeModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(
        message: 'Failed to get employees from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<EmployeeModel> getEmployeeById(String id) async {
    try {
      final response = await _apiClient.get('${ApiEndpoints.employees}/$id');
      final data = response.data['data'] ?? response.data;
      return EmployeeModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to get employee from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<EmployeeModel> getEmployeeByCode(String code) async {
    try {
      final response = await _apiClient.get(
        '${ApiEndpoints.employees}/code/$code',
      );
      final data = response.data['data'] ?? response.data;
      return EmployeeModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to get employee from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<EmployeeModel> createEmployee(EmployeeModel employee) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.employees,
        data: employee.toJson(),
      );
      final data = response.data['data'] ?? response.data;
      return EmployeeModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to create employee on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<EmployeeModel> updateEmployee(EmployeeModel employee) async {
    try {
      final response = await _apiClient.put(
        '${ApiEndpoints.employees}/${employee.id}',
        data: employee.toJson(),
      );
      final data = response.data['data'] ?? response.data;
      return EmployeeModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to update employee on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteEmployee(String id) async {
    try {
      await _apiClient.delete('${ApiEndpoints.employees}/$id');
    } catch (e) {
      throw ServerException(
        message: 'Failed to delete employee from server: ${e.toString()}',
      );
    }
  }

  // ==================== Department Operations ====================

  @override
  Future<List<DepartmentModel>> getDepartments({bool? isActive}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (isActive != null) queryParams['is_active'] = isActive;

      final response = await _apiClient.get(
        ApiEndpoints.departments,
        queryParameters: queryParams,
      );

      final List<dynamic> data = response.data['data'] ?? response.data;
      return data.map((json) => DepartmentModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(
        message: 'Failed to get departments from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<DepartmentModel> getDepartmentById(String id) async {
    try {
      final response = await _apiClient.get('${ApiEndpoints.departments}/$id');
      final data = response.data['data'] ?? response.data;
      return DepartmentModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to get department from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<DepartmentModel> createDepartment(DepartmentModel department) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.departments,
        data: department.toJson(),
      );
      final data = response.data['data'] ?? response.data;
      return DepartmentModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to create department on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<DepartmentModel> updateDepartment(DepartmentModel department) async {
    try {
      final response = await _apiClient.put(
        '${ApiEndpoints.departments}/${department.id}',
        data: department.toJson(),
      );
      final data = response.data['data'] ?? response.data;
      return DepartmentModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to update department on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteDepartment(String id) async {
    try {
      await _apiClient.delete('${ApiEndpoints.departments}/$id');
    } catch (e) {
      throw ServerException(
        message: 'Failed to delete department from server: ${e.toString()}',
      );
    }
  }

  // ==================== Position Operations ====================

  @override
  Future<List<PositionModel>> getPositions({
    String? departmentId,
    bool? isActive,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (departmentId != null) queryParams['department_id'] = departmentId;
      if (isActive != null) queryParams['is_active'] = isActive;

      final response = await _apiClient.get(
        ApiEndpoints.positions,
        queryParameters: queryParams,
      );

      final List<dynamic> data = response.data['data'] ?? response.data;
      return data.map((json) => PositionModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(
        message: 'Failed to get positions from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<PositionModel> getPositionById(String id) async {
    try {
      final response = await _apiClient.get('${ApiEndpoints.positions}/$id');
      final data = response.data['data'] ?? response.data;
      return PositionModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to get position from server: ${e.toString()}',
      );
    }
  }

  @override
  Future<PositionModel> createPosition(PositionModel position) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.positions,
        data: position.toJson(),
      );
      final data = response.data['data'] ?? response.data;
      return PositionModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to create position on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<PositionModel> updatePosition(PositionModel position) async {
    try {
      final response = await _apiClient.put(
        '${ApiEndpoints.positions}/${position.id}',
        data: position.toJson(),
      );
      final data = response.data['data'] ?? response.data;
      return PositionModel.fromJson(data);
    } catch (e) {
      throw ServerException(
        message: 'Failed to update position on server: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deletePosition(String id) async {
    try {
      await _apiClient.delete('${ApiEndpoints.positions}/$id');
    } catch (e) {
      throw ServerException(
        message: 'Failed to delete position from server: ${e.toString()}',
      );
    }
  }
}

