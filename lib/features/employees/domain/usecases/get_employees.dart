import 'package:injectable/injectable.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/employee.dart';
import '../repositories/employee_repository.dart';

/// Use case for getting employees
@lazySingleton
class GetEmployees {
  final EmployeeRepository _repository;
  
  GetEmployees(this._repository);
  
  ResultFuture<List<Employee>> call({
    int? page,
    int? limit,
    String? searchQuery,
    String? departmentId,
    String? positionId,
    String? status,
  }) {
    return _repository.getEmployees(
      page: page,
      limit: limit,
      searchQuery: searchQuery,
      departmentId: departmentId,
      positionId: positionId,
      status: status,
    );
  }
}

