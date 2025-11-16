import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:hr_management_system/core/services/api_service.dart';
import 'package:hr_management_system/core/repositories/employees_repository.dart';
import 'package:hr_management_system/features/employees/models/employee_model.dart';

void main() {
  group('EmployeesRepository', () {
    test('list() maps JSON response to Employee models', () async {
      final api = ApiService();
      api.addInterceptor(InterceptorsWrapper(onRequest: (options, handler) {
        if (options.path == '/employees' && options.method == 'GET') {
          return handler.resolve(Response(requestOptions: options, data: [
            {
              'id': 1,
              'employee_number': 'EMP-001',
              'first_name': 'Ahmed',
              'last_name': 'Ali',
              'full_name': 'Ahmed Ali',
              'email': 'ahmed@example.com',
              'created_at': DateTime.now().toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
            },
          ]));
        }
        handler.next(options);
      }));

      final repo = EmployeesRepository(api: api);
      final list = await repo.list();
      expect(list, isNotEmpty);
      expect(list.first, isA<Employee>());
      expect(list.first.employeeNumber, 'EMP-001');
      expect(list.first.fullName, 'Ahmed Ali');
    });
  });
}