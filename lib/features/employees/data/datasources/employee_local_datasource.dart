import 'package:injectable/injectable.dart';
import '../../../../core/database/database_service.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/department_model.dart';
import '../models/employee_model.dart';
import '../models/position_model.dart';

/// Abstract interface for employee local data source
abstract class EmployeeLocalDataSource {
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
  Future<void> cacheEmployees(List<EmployeeModel> employees);
  Future<void> cacheEmployee(EmployeeModel employee);
  Future<void> deleteEmployee(String id);
  Future<void> clearEmployees();

  // Department operations
  Future<List<DepartmentModel>> getDepartments({bool? isActive});
  Future<DepartmentModel> getDepartmentById(String id);
  Future<void> cacheDepartments(List<DepartmentModel> departments);
  Future<void> cacheDepartment(DepartmentModel department);
  Future<void> deleteDepartment(String id);

  // Position operations
  Future<List<PositionModel>> getPositions({
    String? departmentId,
    bool? isActive,
  });
  Future<PositionModel> getPositionById(String id);
  Future<void> cachePositions(List<PositionModel> positions);
  Future<void> cachePosition(PositionModel position);
  Future<void> deletePosition(String id);
}

/// Implementation of employee local data source using SQLite
@LazySingleton(as: EmployeeLocalDataSource)
class EmployeeLocalDataSourceImpl implements EmployeeLocalDataSource {
  final DatabaseService _databaseService;

  EmployeeLocalDataSourceImpl(this._databaseService);

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
      final whereConditions = <String>[];
      final whereArgs = <dynamic>[];

      if (departmentId != null) {
        whereConditions.add('e.department_id = ?');
        whereArgs.add(departmentId);
      }

      if (positionId != null) {
        whereConditions.add('e.position_id = ?');
        whereArgs.add(positionId);
      }

      if (status != null) {
        whereConditions.add('e.status = ?');
        whereArgs.add(status);
      }

      final whereClause =
          whereConditions.isNotEmpty ? 'WHERE ${whereConditions.join(' AND ')}' : '';

      final limitClause = limit != null ? 'LIMIT $limit' : '';
      final offsetClause = offset != null ? 'OFFSET $offset' : '';

      final sql = '''
        SELECT 
          e.*,
          d.name as department_name,
          p.title as position_title,
          m.full_name as manager_name
        FROM employees e
        LEFT JOIN departments d ON e.department_id = d.id
        LEFT JOIN positions p ON e.position_id = p.id
        LEFT JOIN employees m ON e.manager_id = m.id
        $whereClause
        ORDER BY e.created_at DESC
        $limitClause $offsetClause
      ''';

      final results = await _databaseService.query(sql, arguments: whereArgs);
      return results.map((map) => EmployeeModel.fromDatabase(map)).toList();
    } catch (e) {
      throw CacheException(
        message: 'Failed to get employees from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<EmployeeModel> getEmployeeById(String id) async {
    try {
      final sql = '''
        SELECT 
          e.*,
          d.name as department_name,
          p.title as position_title,
          m.full_name as manager_name
        FROM employees e
        LEFT JOIN departments d ON e.department_id = d.id
        LEFT JOIN positions p ON e.position_id = p.id
        LEFT JOIN employees m ON e.manager_id = m.id
        WHERE e.id = ?
      ''';

      final results = await _databaseService.query(sql, arguments: [id]);

      if (results.isEmpty) {
        throw CacheException(message: 'Employee not found in cache');
      }

      return EmployeeModel.fromDatabase(results.first);
    } catch (e) {
      throw CacheException(
        message: 'Failed to get employee from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<EmployeeModel> getEmployeeByCode(String code) async {
    try {
      final sql = '''
        SELECT 
          e.*,
          d.name as department_name,
          p.title as position_title,
          m.full_name as manager_name
        FROM employees e
        LEFT JOIN departments d ON e.department_id = d.id
        LEFT JOIN positions p ON e.position_id = p.id
        LEFT JOIN employees m ON e.manager_id = m.id
        WHERE e.employee_code = ?
      ''';

      final results = await _databaseService.query(sql, arguments: [code]);

      if (results.isEmpty) {
        throw CacheException(message: 'Employee not found in cache');
      }

      return EmployeeModel.fromDatabase(results.first);
    } catch (e) {
      throw CacheException(
        message: 'Failed to get employee from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cacheEmployees(List<EmployeeModel> employees) async {
    try {
      await _databaseService.transaction(() async {
        for (final employee in employees) {
          await _databaseService.insert(
            'employees',
            employee.toDatabase(),
            conflictAlgorithm: 'replace',
          );
        }
      });
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache employees: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cacheEmployee(EmployeeModel employee) async {
    try {
      await _databaseService.insert(
        'employees',
        employee.toDatabase(),
        conflictAlgorithm: 'replace',
      );
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache employee: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteEmployee(String id) async {
    try {
      await _databaseService.delete(
        'employees',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw CacheException(
        message: 'Failed to delete employee from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> clearEmployees() async {
    try {
      await _databaseService.delete('employees');
    } catch (e) {
      throw CacheException(
        message: 'Failed to clear employees from cache: ${e.toString()}',
      );
    }
  }

  // ==================== Department Operations ====================

  @override
  Future<List<DepartmentModel>> getDepartments({bool? isActive}) async {
    try {
      final whereClause = isActive != null ? 'WHERE is_active = ?' : '';
      final whereArgs = isActive != null ? [isActive ? 1 : 0] : null;

      final sql = '''
        SELECT 
          d.*,
          m.full_name as manager_name,
          (SELECT COUNT(*) FROM employees WHERE department_id = d.id) as employee_count
        FROM departments d
        LEFT JOIN employees m ON d.manager_id = m.id
        $whereClause
        ORDER BY d.name ASC
      ''';

      final results = await _databaseService.query(sql, arguments: whereArgs);
      return results.map((map) => DepartmentModel.fromDatabase(map)).toList();
    } catch (e) {
      throw CacheException(
        message: 'Failed to get departments from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<DepartmentModel> getDepartmentById(String id) async {
    try {
      final sql = '''
        SELECT 
          d.*,
          m.full_name as manager_name,
          (SELECT COUNT(*) FROM employees WHERE department_id = d.id) as employee_count
        FROM departments d
        LEFT JOIN employees m ON d.manager_id = m.id
        WHERE d.id = ?
      ''';

      final results = await _databaseService.query(sql, arguments: [id]);

      if (results.isEmpty) {
        throw CacheException(message: 'Department not found in cache');
      }

      return DepartmentModel.fromDatabase(results.first);
    } catch (e) {
      throw CacheException(
        message: 'Failed to get department from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cacheDepartments(List<DepartmentModel> departments) async {
    try {
      await _databaseService.transaction(() async {
        for (final department in departments) {
          await _databaseService.insert(
            'departments',
            department.toDatabase(),
            conflictAlgorithm: 'replace',
          );
        }
      });
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache departments: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cacheDepartment(DepartmentModel department) async {
    try {
      await _databaseService.insert(
        'departments',
        department.toDatabase(),
        conflictAlgorithm: 'replace',
      );
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache department: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteDepartment(String id) async {
    try {
      await _databaseService.delete(
        'departments',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw CacheException(
        message: 'Failed to delete department from cache: ${e.toString()}',
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
      final whereConditions = <String>[];
      final whereArgs = <dynamic>[];

      if (departmentId != null) {
        whereConditions.add('p.department_id = ?');
        whereArgs.add(departmentId);
      }

      if (isActive != null) {
        whereConditions.add('p.is_active = ?');
        whereArgs.add(isActive ? 1 : 0);
      }

      final whereClause =
          whereConditions.isNotEmpty ? 'WHERE ${whereConditions.join(' AND ')}' : '';

      final sql = '''
        SELECT 
          p.*,
          d.name as department_name
        FROM positions p
        LEFT JOIN departments d ON p.department_id = d.id
        $whereClause
        ORDER BY p.title ASC
      ''';

      final results = await _databaseService.query(sql, arguments: whereArgs.isNotEmpty ? whereArgs : null);
      return results.map((map) => PositionModel.fromDatabase(map)).toList();
    } catch (e) {
      throw CacheException(
        message: 'Failed to get positions from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<PositionModel> getPositionById(String id) async {
    try {
      final sql = '''
        SELECT 
          p.*,
          d.name as department_name
        FROM positions p
        LEFT JOIN departments d ON p.department_id = d.id
        WHERE p.id = ?
      ''';

      final results = await _databaseService.query(sql, arguments: [id]);

      if (results.isEmpty) {
        throw CacheException(message: 'Position not found in cache');
      }

      return PositionModel.fromDatabase(results.first);
    } catch (e) {
      throw CacheException(
        message: 'Failed to get position from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cachePositions(List<PositionModel> positions) async {
    try {
      await _databaseService.transaction(() async {
        for (final position in positions) {
          await _databaseService.insert(
            'positions',
            position.toDatabase(),
            conflictAlgorithm: 'replace',
          );
        }
      });
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache positions: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cachePosition(PositionModel position) async {
    try {
      await _databaseService.insert(
        'positions',
        position.toDatabase(),
        conflictAlgorithm: 'replace',
      );
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache position: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deletePosition(String id) async {
    try {
      await _databaseService.delete(
        'positions',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw CacheException(
        message: 'Failed to delete position from cache: ${e.toString()}',
      );
    }
  }
}

