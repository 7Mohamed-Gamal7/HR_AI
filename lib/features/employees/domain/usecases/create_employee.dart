import 'package:injectable/injectable.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/employee.dart';
import '../repositories/employee_repository.dart';

/// Use case for creating an employee
@lazySingleton
class CreateEmployee {
  final EmployeeRepository _repository;
  
  CreateEmployee(this._repository);
  
  ResultVoid call(Employee employee) {
    return _repository.createEmployee(employee);
  }
}

