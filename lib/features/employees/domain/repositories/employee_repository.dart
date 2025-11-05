import '../../../../core/utils/typedef.dart';
import '../entities/employee.dart';
import '../entities/department.dart';
import '../entities/position.dart';

/// Employee repository interface
abstract class EmployeeRepository {
  // Employee operations
  ResultFuture<List<Employee>> getEmployees({
    int? page,
    int? limit,
    String? searchQuery,
    String? departmentId,
    String? positionId,
    String? status,
  });
  
  ResultFuture<Employee> getEmployeeById(String id);
  
  ResultFuture<Employee> getEmployeeByCode(String employeeCode);
  
  ResultFuture<void> createEmployee(Employee employee);
  
  ResultFuture<void> updateEmployee(Employee employee);
  
  ResultFuture<void> deleteEmployee(String id);
  
  ResultFuture<List<Employee>> getEmployeesByDepartment(String departmentId);
  
  ResultFuture<List<Employee>> getEmployeesByPosition(String positionId);
  
  ResultFuture<List<Employee>> getEmployeesByManager(String managerId);
  
  ResultFuture<int> getEmployeeCount();
  
  // Department operations
  ResultFuture<List<Department>> getDepartments();
  
  ResultFuture<Department> getDepartmentById(String id);
  
  ResultFuture<void> createDepartment(Department department);
  
  ResultFuture<void> updateDepartment(Department department);
  
  ResultFuture<void> deleteDepartment(String id);
  
  // Position operations
  ResultFuture<List<Position>> getPositions({String? departmentId});
  
  ResultFuture<Position> getPositionById(String id);
  
  ResultFuture<void> createPosition(Position position);
  
  ResultFuture<void> updatePosition(Position position);
  
  ResultFuture<void> deletePosition(String id);
}

