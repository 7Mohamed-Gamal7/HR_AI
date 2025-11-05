import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/entities/department.dart';
import '../../domain/entities/employee.dart';
import '../../domain/entities/position.dart';
import '../../domain/repositories/employee_repository.dart';
import '../datasources/employee_local_datasource.dart';
import '../datasources/employee_remote_datasource.dart';
import '../models/department_model.dart';
import '../models/employee_model.dart';
import '../models/position_model.dart';

/// Implementation of EmployeeRepository with offline-first architecture
@LazySingleton(as: EmployeeRepository)
class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDataSource _remoteDataSource;
  final EmployeeLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  EmployeeRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  // ==================== Employee Operations ====================

  @override
  ResultFuture<List<Employee>> getEmployees({
    String? departmentId,
    String? positionId,
    String? status,
    int? limit,
    int? offset,
  }) async {
    try {
      // Check network connectivity
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          // Fetch from remote source
          final remoteEmployees = await _remoteDataSource.getEmployees(
            departmentId: departmentId,
            positionId: positionId,
            status: status,
            limit: limit,
            offset: offset,
          );

          // Cache the fetched data
          await _localDataSource.cacheEmployees(remoteEmployees);

          // Convert to domain entities
          final employees = remoteEmployees
              .map((model) => model.toEntity())
              .toList();
          return Right(employees);
        } on ServerException {
          // If remote fetch fails, fall back to cache
          return _getEmployeesFromCache(
            departmentId: departmentId,
            positionId: positionId,
            status: status,
            limit: limit,
            offset: offset,
          );
        }
      } else {
        // Offline - fetch from cache
        return _getEmployeesFromCache(
          departmentId: departmentId,
          positionId: positionId,
          status: status,
          limit: limit,
          offset: offset,
        );
      }
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get employees: ${e.toString()}'),
      );
    }
  }

  /// Helper method to get employees from cache
  Future<Either<Failure, List<Employee>>> _getEmployeesFromCache({
    String? departmentId,
    String? positionId,
    String? status,
    int? limit,
    int? offset,
  }) async {
    try {
      final cachedEmployees = await _localDataSource.getEmployees(
        departmentId: departmentId,
        positionId: positionId,
        status: status,
        limit: limit,
        offset: offset,
      );

      final employees = cachedEmployees
          .map((model) => model.toEntity())
          .toList();
      return Right(employees);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  ResultFuture<Employee> getEmployeeById(String id) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteEmployee = await _remoteDataSource.getEmployeeById(id);
          await _localDataSource.cacheEmployee(remoteEmployee);
          return Right(remoteEmployee.toEntity());
        } on ServerException {
          return _getEmployeeByIdFromCache(id);
        }
      } else {
        return _getEmployeeByIdFromCache(id);
      }
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get employee: ${e.toString()}'),
      );
    }
  }

  /// Helper method to get employee by ID from cache
  Future<Either<Failure, Employee>> _getEmployeeByIdFromCache(String id) async {
    try {
      final cachedEmployee = await _localDataSource.getEmployeeById(id);
      return Right(cachedEmployee.toEntity());
    } on CacheException catch (e) {
      return Left(NotFoundFailure(message: 'Employee not found: ${e.message}'));
    }
  }

  @override
  ResultFuture<Employee> getEmployeeByCode(String code) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteEmployee = await _remoteDataSource.getEmployeeByCode(
            code,
          );
          await _localDataSource.cacheEmployee(remoteEmployee);
          return Right(remoteEmployee.toEntity());
        } on ServerException {
          return _getEmployeeByCodeFromCache(code);
        }
      } else {
        return _getEmployeeByCodeFromCache(code);
      }
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get employee: ${e.toString()}'),
      );
    }
  }

  /// Helper method to get employee by code from cache
  Future<Either<Failure, Employee>> _getEmployeeByCodeFromCache(
    String code,
  ) async {
    try {
      final cachedEmployee = await _localDataSource.getEmployeeByCode(code);
      return Right(cachedEmployee.toEntity());
    } on CacheException catch (e) {
      return Left(NotFoundFailure(message: 'Employee not found: ${e.message}'));
    }
  }

  @override
  ResultFuture<Employee> createEmployee(Employee employee) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return Left(
          NetworkFailure(
            message: 'No internet connection. Cannot create employee.',
          ),
        );
      }

      final employeeModel = EmployeeModel.fromEntity(employee);
      final createdEmployee = await _remoteDataSource.createEmployee(
        employeeModel,
      );

      // Cache the created employee
      await _localDataSource.cacheEmployee(createdEmployee);

      return Right(createdEmployee.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to create employee: ${e.toString()}'),
      );
    }
  }

  @override
  ResultFuture<Employee> updateEmployee(Employee employee) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return Left(
          NetworkFailure(
            message: 'No internet connection. Cannot update employee.',
          ),
        );
      }

      final employeeModel = EmployeeModel.fromEntity(employee);
      final updatedEmployee = await _remoteDataSource.updateEmployee(
        employeeModel,
      );

      // Update cache
      await _localDataSource.cacheEmployee(updatedEmployee);

      return Right(updatedEmployee.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to update employee: ${e.toString()}'),
      );
    }
  }

  @override
  ResultVoid deleteEmployee(String id) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return Left(
          NetworkFailure(
            message: 'No internet connection. Cannot delete employee.',
          ),
        );
      }

      await _remoteDataSource.deleteEmployee(id);

      // Remove from cache
      await _localDataSource.deleteEmployee(id);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to delete employee: ${e.toString()}'),
      );
    }
  }

  // ==================== Department Operations ====================

  @override
  ResultFuture<List<Department>> getDepartments({bool? isActive}) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteDepartments = await _remoteDataSource.getDepartments(
            isActive: isActive,
          );

          await _localDataSource.cacheDepartments(remoteDepartments);

          final departments = remoteDepartments
              .map((model) => model.toEntity())
              .toList();
          return Right(departments);
        } on ServerException {
          return _getDepartmentsFromCache(isActive: isActive);
        }
      } else {
        return _getDepartmentsFromCache(isActive: isActive);
      }
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get departments: ${e.toString()}'),
      );
    }
  }

  /// Helper method to get departments from cache
  Future<Either<Failure, List<Department>>> _getDepartmentsFromCache({
    bool? isActive,
  }) async {
    try {
      final cachedDepartments = await _localDataSource.getDepartments(
        isActive: isActive,
      );

      final departments = cachedDepartments
          .map((model) => model.toEntity())
          .toList();
      return Right(departments);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  ResultFuture<Department> getDepartmentById(String id) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteDepartment = await _remoteDataSource.getDepartmentById(
            id,
          );
          await _localDataSource.cacheDepartment(remoteDepartment);
          return Right(remoteDepartment.toEntity());
        } on ServerException {
          return _getDepartmentByIdFromCache(id);
        }
      } else {
        return _getDepartmentByIdFromCache(id);
      }
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get department: ${e.toString()}'),
      );
    }
  }

  /// Helper method to get department by ID from cache
  Future<Either<Failure, Department>> _getDepartmentByIdFromCache(
    String id,
  ) async {
    try {
      final cachedDepartment = await _localDataSource.getDepartmentById(id);
      return Right(cachedDepartment.toEntity());
    } on CacheException catch (e) {
      return Left(
        NotFoundFailure(message: 'Department not found: ${e.message}'),
      );
    }
  }

  @override
  ResultFuture<Department> createDepartment(Department department) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return Left(
          NetworkFailure(
            message: 'No internet connection. Cannot create department.',
          ),
        );
      }

      final departmentModel = DepartmentModel.fromEntity(department);
      final createdDepartment = await _remoteDataSource.createDepartment(
        departmentModel,
      );

      await _localDataSource.cacheDepartment(createdDepartment);

      return Right(createdDepartment.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to create department: ${e.toString()}'),
      );
    }
  }

  @override
  ResultFuture<Department> updateDepartment(Department department) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return Left(
          NetworkFailure(
            message: 'No internet connection. Cannot update department.',
          ),
        );
      }

      final departmentModel = DepartmentModel.fromEntity(department);
      final updatedDepartment = await _remoteDataSource.updateDepartment(
        departmentModel,
      );

      await _localDataSource.cacheDepartment(updatedDepartment);

      return Right(updatedDepartment.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to update department: ${e.toString()}'),
      );
    }
  }

  @override
  ResultVoid deleteDepartment(String id) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return Left(
          NetworkFailure(
            message: 'No internet connection. Cannot delete department.',
          ),
        );
      }

      await _remoteDataSource.deleteDepartment(id);
      await _localDataSource.deleteDepartment(id);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to delete department: ${e.toString()}'),
      );
    }
  }

  // ==================== Position Operations ====================

  @override
  ResultFuture<List<Position>> getPositions({
    String? departmentId,
    bool? isActive,
  }) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remotePositions = await _remoteDataSource.getPositions(
            departmentId: departmentId,
            isActive: isActive,
          );

          await _localDataSource.cachePositions(remotePositions);

          final positions = remotePositions
              .map((model) => model.toEntity())
              .toList();
          return Right(positions);
        } on ServerException {
          return _getPositionsFromCache(
            departmentId: departmentId,
            isActive: isActive,
          );
        }
      } else {
        return _getPositionsFromCache(
          departmentId: departmentId,
          isActive: isActive,
        );
      }
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get positions: ${e.toString()}'),
      );
    }
  }

  /// Helper method to get positions from cache
  Future<Either<Failure, List<Position>>> _getPositionsFromCache({
    String? departmentId,
    bool? isActive,
  }) async {
    try {
      final cachedPositions = await _localDataSource.getPositions(
        departmentId: departmentId,
        isActive: isActive,
      );

      final positions = cachedPositions
          .map((model) => model.toEntity())
          .toList();
      return Right(positions);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  ResultFuture<Position> getPositionById(String id) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remotePosition = await _remoteDataSource.getPositionById(id);
          await _localDataSource.cachePosition(remotePosition);
          return Right(remotePosition.toEntity());
        } on ServerException {
          return _getPositionByIdFromCache(id);
        }
      } else {
        return _getPositionByIdFromCache(id);
      }
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get position: ${e.toString()}'),
      );
    }
  }

  /// Helper method to get position by ID from cache
  Future<Either<Failure, Position>> _getPositionByIdFromCache(String id) async {
    try {
      final cachedPosition = await _localDataSource.getPositionById(id);
      return Right(cachedPosition.toEntity());
    } on CacheException catch (e) {
      return Left(NotFoundFailure(message: 'Position not found: ${e.message}'));
    }
  }

  @override
  ResultFuture<Position> createPosition(Position position) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return Left(
          NetworkFailure(
            message: 'No internet connection. Cannot create position.',
          ),
        );
      }

      final positionModel = PositionModel.fromEntity(position);
      final createdPosition = await _remoteDataSource.createPosition(
        positionModel,
      );

      await _localDataSource.cachePosition(createdPosition);

      return Right(createdPosition.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to create position: ${e.toString()}'),
      );
    }
  }

  @override
  ResultFuture<Position> updatePosition(Position position) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return Left(
          NetworkFailure(
            message: 'No internet connection. Cannot update position.',
          ),
        );
      }

      final positionModel = PositionModel.fromEntity(position);
      final updatedPosition = await _remoteDataSource.updatePosition(
        positionModel,
      );

      await _localDataSource.cachePosition(updatedPosition);

      return Right(updatedPosition.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to update position: ${e.toString()}'),
      );
    }
  }

  @override
  ResultVoid deletePosition(String id) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return Left(
          NetworkFailure(
            message: 'No internet connection. Cannot delete position.',
          ),
        );
      }

      await _remoteDataSource.deletePosition(id);
      await _localDataSource.deletePosition(id);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to delete position: ${e.toString()}'),
      );
    }
  }
}
