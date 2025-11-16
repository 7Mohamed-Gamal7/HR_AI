import 'dart:convert';
import 'package:hr_management_system/core/repositories/base_repository.dart';
import 'package:hr_management_system/core/services/api_service.dart';
import 'package:hr_management_system/features/employees/models/employee_model.dart';

/// مستودع الموظفين: يتواصل مع واجهة REST المتصلة بـ SQL Server
class EmployeesRepository implements BaseRepository<Employee> {
  static const String _endpoint = '/employees';

  final ApiService _api;

  EmployeesRepository({ApiService? api}) : _api = api ?? ApiService.instance;

  @override
  Future<List<Employee>> list({Map<String, dynamic>? query}) async {
    final res = await _api.get<List<dynamic>>(_endpoint, query: query);
    final data = res.data ?? [];
    return data.map((e) => Employee.fromMap(_normalize(e))).toList();
  }

  @override
  Future<Employee> getById(String id) async {
    final res = await _api.get<Map<String, dynamic>>('$_endpoint/$id');
    return Employee.fromMap(_normalize(res.data ?? {}));
  }

  @override
  Future<Employee> create(Employee item) async {
    final res = await _api.post<Map<String, dynamic>>(_endpoint, data: item.toMap());
    return Employee.fromMap(_normalize(res.data ?? {}));
  }

  @override
  Future<Employee> update(String id, Employee item) async {
    final res = await _api.put<Map<String, dynamic>>('$_endpoint/$id', data: item.toMap());
    return Employee.fromMap(_normalize(res.data ?? {}));
  }

  @override
  Future<void> delete(String id) async {
    await _api.delete<void>('$_endpoint/$id');
  }

  Map<String, dynamic> _normalize(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is String) return jsonDecode(data) as Map<String, dynamic>;
    return {};
  }
}