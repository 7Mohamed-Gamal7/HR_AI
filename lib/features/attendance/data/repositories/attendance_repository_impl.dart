import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/entities/attendance.dart';
import '../../domain/entities/attendance_rule.dart';
import '../../domain/entities/holiday.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_local_datasource.dart';
import '../datasources/attendance_remote_datasource.dart';
import '../models/attendance_model.dart';
import '../models/attendance_rule_model.dart';
import '../models/holiday_model.dart';

/// Implementation of AttendanceRepository with offline-first architecture
@LazySingleton(as: AttendanceRepository)
class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource _remoteDataSource;
  final AttendanceLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  AttendanceRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  // ==================== Attendance Operations ====================

  @override
  ResultFuture<List<Attendance>> getAttendances({
    String? employeeId,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    int? limit,
    int? offset,
  }) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteAttendances = await _remoteDataSource.getAttendances(
            employeeId: employeeId,
            startDate: startDate,
            endDate: endDate,
            status: status,
            limit: limit,
            offset: offset,
          );

          await _localDataSource.cacheAttendances(remoteAttendances);

          final attendances =
              remoteAttendances.map((model) => model.toEntity()).toList();
          return Right(attendances);
        } on ServerException {
          return _getAttendancesFromCache(
            employeeId: employeeId,
            startDate: startDate,
            endDate: endDate,
            status: status,
            limit: limit,
            offset: offset,
          );
        }
      } else {
        return _getAttendancesFromCache(
          employeeId: employeeId,
          startDate: startDate,
          endDate: endDate,
          status: status,
          limit: limit,
          offset: offset,
        );
      }
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get attendances: ${e.toString()}'),
      );
    }
  }

  /// Helper method to get attendances from cache
  Future<Either<Failure, List<Attendance>>> _getAttendancesFromCache({
    String? employeeId,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    int? limit,
    int? offset,
  }) async {
    try {
      final cachedAttendances = await _localDataSource.getAttendances(
        employeeId: employeeId,
        startDate: startDate,
        endDate: endDate,
        status: status,
        limit: limit,
        offset: offset,
      );

      final attendances =
          cachedAttendances.map((model) => model.toEntity()).toList();
      return Right(attendances);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  ResultFuture<Attendance> getAttendanceById(String id) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteAttendance = await _remoteDataSource.getAttendanceById(
            id,
          );
          await _localDataSource.cacheAttendance(remoteAttendance);
          return Right(remoteAttendance.toEntity());
        } on ServerException {
          return _getAttendanceByIdFromCache(id);
        }
      } else {
        return _getAttendanceByIdFromCache(id);
      }
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get attendance: ${e.toString()}'),
      );
    }
  }

  /// Helper method to get attendance by ID from cache
  Future<Either<Failure, Attendance>> _getAttendanceByIdFromCache(
    String id,
  ) async {
    try {
      final cachedAttendance = await _localDataSource.getAttendanceById(id);
      return Right(cachedAttendance.toEntity());
    } on CacheException catch (e) {
      return Left(
        NotFoundFailure(message: 'Attendance not found: ${e.message}'),
      );
    }
  }

  @override
  ResultFuture<Attendance?> getAttendanceByEmployeeAndDate(
    String employeeId,
    DateTime date,
  ) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteAttendance = await _remoteDataSource
              .getAttendanceByEmployeeAndDate(employeeId, date);

          if (remoteAttendance != null) {
            await _localDataSource.cacheAttendance(remoteAttendance);
            return Right(remoteAttendance.toEntity());
          }
          return const Right(null);
        } on ServerException {
          return _getAttendanceByEmployeeAndDateFromCache(employeeId, date);
        }
      } else {
        return _getAttendanceByEmployeeAndDateFromCache(employeeId, date);
      }
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get attendance: ${e.toString()}'),
      );
    }
  }

  /// Helper method to get attendance by employee and date from cache
  Future<Either<Failure, Attendance?>> _getAttendanceByEmployeeAndDateFromCache(
    String employeeId,
    DateTime date,
  ) async {
    try {
      final cachedAttendance = await _localDataSource
          .getAttendanceByEmployeeAndDate(employeeId, date);
      return Right(cachedAttendance?.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  ResultFuture<Attendance> createAttendance(Attendance attendance) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message: 'No internet connection. Cannot create attendance.',
          ),
        );
      }

      final attendanceModel = AttendanceModel.fromEntity(attendance);
      final createdAttendance = await _remoteDataSource.createAttendance(
        attendanceModel,
      );

      await _localDataSource.cacheAttendance(createdAttendance);

      return Right(createdAttendance.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to create attendance: ${e.toString()}'),
      );
    }
  }

  @override
  ResultFuture<Attendance> updateAttendance(Attendance attendance) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message: 'No internet connection. Cannot update attendance.',
          ),
        );
      }

      final attendanceModel = AttendanceModel.fromEntity(attendance);
      final updatedAttendance = await _remoteDataSource.updateAttendance(
        attendanceModel,
      );

      await _localDataSource.cacheAttendance(updatedAttendance);

      return Right(updatedAttendance.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to update attendance: ${e.toString()}'),
      );
    }
  }

  @override
  ResultVoid deleteAttendance(String id) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message: 'No internet connection. Cannot delete attendance.',
          ),
        );
      }

      await _remoteDataSource.deleteAttendance(id);
      await _localDataSource.deleteAttendance(id);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to delete attendance: ${e.toString()}'),
      );
    }
  }

  @override
  ResultFuture<Attendance> checkIn(
    String employeeId, {
    String? method,
    String? location,
  }) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(message: 'No internet connection. Cannot check in.'),
        );
      }

      final attendance = await _remoteDataSource.checkIn(
        employeeId,
        method: method,
        location: location,
      );

      await _localDataSource.cacheAttendance(attendance);

      return Right(attendance.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to check in: ${e.toString()}'),
      );
    }
  }

  @override
  ResultFuture<Attendance> checkOut(
    String attendanceId, {
    String? method,
    String? location,
  }) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(message: 'No internet connection. Cannot check out.'),
        );
      }

      final attendance = await _remoteDataSource.checkOut(
        attendanceId,
        method: method,
        location: location,
      );

      await _localDataSource.cacheAttendance(attendance);

      return Right(attendance.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to check out: ${e.toString()}'),
      );
    }
  }

  // ==================== Attendance Rule Operations ====================

  @override
  ResultFuture<List<AttendanceRule>> getAttendanceRules({
    bool? isActive,
  }) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteRules = await _remoteDataSource.getAttendanceRules(
            isActive: isActive,
          );

          await _localDataSource.cacheAttendanceRules(remoteRules);

          final rules = remoteRules.map((model) => model.toEntity()).toList();
          return Right(rules);
        } on ServerException {
          return _getAttendanceRulesFromCache(isActive: isActive);
        }
      } else {
        return _getAttendanceRulesFromCache(isActive: isActive);
      }
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to get attendance rules: ${e.toString()}',
        ),
      );
    }
  }

  /// Helper method to get attendance rules from cache
  Future<Either<Failure, List<AttendanceRule>>> _getAttendanceRulesFromCache({
    bool? isActive,
  }) async {
    try {
      final cachedRules = await _localDataSource.getAttendanceRules(
        isActive: isActive,
      );

      final rules = cachedRules.map((model) => model.toEntity()).toList();
      return Right(rules);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  ResultFuture<AttendanceRule> getAttendanceRuleById(String id) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteRule = await _remoteDataSource.getAttendanceRuleById(id);
          await _localDataSource.cacheAttendanceRule(remoteRule);
          return Right(remoteRule.toEntity());
        } on ServerException {
          return _getAttendanceRuleByIdFromCache(id);
        }
      } else {
        return _getAttendanceRuleByIdFromCache(id);
      }
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to get attendance rule: ${e.toString()}',
        ),
      );
    }
  }

  /// Helper method to get attendance rule by ID from cache
  Future<Either<Failure, AttendanceRule>> _getAttendanceRuleByIdFromCache(
    String id,
  ) async {
    try {
      final cachedRule = await _localDataSource.getAttendanceRuleById(id);
      return Right(cachedRule.toEntity());
    } on CacheException catch (e) {
      return Left(
        NotFoundFailure(message: 'Attendance rule not found: ${e.message}'),
      );
    }
  }

  @override
  ResultFuture<AttendanceRule?> getDefaultAttendanceRule() async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteRule = await _remoteDataSource.getDefaultAttendanceRule();

          if (remoteRule != null) {
            await _localDataSource.cacheAttendanceRule(remoteRule);
            return Right(remoteRule.toEntity());
          }
          return const Right(null);
        } on ServerException {
          return _getDefaultAttendanceRuleFromCache();
        }
      } else {
        return _getDefaultAttendanceRuleFromCache();
      }
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to get default attendance rule: ${e.toString()}',
        ),
      );
    }
  }

  /// Helper method to get default attendance rule from cache
  Future<Either<Failure, AttendanceRule?>>
      _getDefaultAttendanceRuleFromCache() async {
    try {
      final cachedRule = await _localDataSource.getDefaultAttendanceRule();
      return Right(cachedRule?.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  ResultFuture<AttendanceRule?> getAttendanceRuleForEmployee(
    String employeeId,
  ) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteRule =
              await _remoteDataSource.getAttendanceRuleForEmployee(employeeId);

          if (remoteRule != null) {
            await _localDataSource.cacheAttendanceRule(remoteRule);
            return Right(remoteRule.toEntity());
          }
          return const Right(null);
        } on ServerException {
          return _getAttendanceRuleForEmployeeFromCache(employeeId);
        }
      } else {
        return _getAttendanceRuleForEmployeeFromCache(employeeId);
      }
    } catch (e) {
      return Left(
        ServerFailure(
          message:
              'Failed to get attendance rule for employee: ${e.toString()}',
        ),
      );
    }
  }

  /// Helper method to get attendance rule for employee from cache
  Future<Either<Failure, AttendanceRule?>>
      _getAttendanceRuleForEmployeeFromCache(String employeeId) async {
    try {
      final cachedRule = await _localDataSource.getAttendanceRuleForEmployee(
        employeeId,
      );
      return Right(cachedRule?.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  ResultFuture<AttendanceRule?> getAttendanceRuleForDepartment(
    String departmentId,
  ) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteRule = await _remoteDataSource
              .getAttendanceRuleForDepartment(departmentId);

          if (remoteRule != null) {
            await _localDataSource.cacheAttendanceRule(remoteRule);
            return Right(remoteRule.toEntity());
          }
          return const Right(null);
        } on ServerException {
          return _getAttendanceRuleForDepartmentFromCache(departmentId);
        }
      } else {
        return _getAttendanceRuleForDepartmentFromCache(departmentId);
      }
    } catch (e) {
      return Left(
        ServerFailure(
          message:
              'Failed to get attendance rule for department: ${e.toString()}',
        ),
      );
    }
  }

  /// Helper method to get attendance rule for department from cache
  Future<Either<Failure, AttendanceRule?>>
      _getAttendanceRuleForDepartmentFromCache(String departmentId) async {
    try {
      final cachedRule = await _localDataSource.getAttendanceRuleForDepartment(
        departmentId,
      );
      return Right(cachedRule?.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  ResultFuture<AttendanceRule> createAttendanceRule(AttendanceRule rule) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message: 'No internet connection. Cannot create attendance rule.',
          ),
        );
      }

      final ruleModel = AttendanceRuleModel.fromEntity(rule);
      final createdRule = await _remoteDataSource.createAttendanceRule(
        ruleModel,
      );

      await _localDataSource.cacheAttendanceRule(createdRule);

      return Right(createdRule.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to create attendance rule: ${e.toString()}',
        ),
      );
    }
  }

  @override
  ResultFuture<AttendanceRule> updateAttendanceRule(AttendanceRule rule) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message: 'No internet connection. Cannot update attendance rule.',
          ),
        );
      }

      final ruleModel = AttendanceRuleModel.fromEntity(rule);
      final updatedRule = await _remoteDataSource.updateAttendanceRule(
        ruleModel,
      );

      await _localDataSource.cacheAttendanceRule(updatedRule);

      return Right(updatedRule.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to update attendance rule: ${e.toString()}',
        ),
      );
    }
  }

  @override
  ResultVoid deleteAttendanceRule(String id) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message: 'No internet connection. Cannot delete attendance rule.',
          ),
        );
      }

      await _remoteDataSource.deleteAttendanceRule(id);
      await _localDataSource.deleteAttendanceRule(id);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to delete attendance rule: ${e.toString()}',
        ),
      );
    }
  }

  // ==================== Holiday Operations ====================

  @override
  ResultFuture<List<Holiday>> getHolidays({
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
  }) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteHolidays = await _remoteDataSource.getHolidays(
            startDate: startDate,
            endDate: endDate,
            isActive: isActive,
          );

          await _localDataSource.cacheHolidays(remoteHolidays);

          final holidays =
              remoteHolidays.map((model) => model.toEntity()).toList();
          return Right(holidays);
        } on ServerException {
          return _getHolidaysFromCache(
            startDate: startDate,
            endDate: endDate,
            isActive: isActive,
          );
        }
      } else {
        return _getHolidaysFromCache(
          startDate: startDate,
          endDate: endDate,
          isActive: isActive,
        );
      }
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get holidays: ${e.toString()}'),
      );
    }
  }

  /// Helper method to get holidays from cache
  Future<Either<Failure, List<Holiday>>> _getHolidaysFromCache({
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
  }) async {
    try {
      final cachedHolidays = await _localDataSource.getHolidays(
        startDate: startDate,
        endDate: endDate,
        isActive: isActive,
      );

      final holidays = cachedHolidays.map((model) => model.toEntity()).toList();
      return Right(holidays);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  ResultFuture<Holiday> getHolidayById(String id) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteHoliday = await _remoteDataSource.getHolidayById(id);
          await _localDataSource.cacheHoliday(remoteHoliday);
          return Right(remoteHoliday.toEntity());
        } on ServerException {
          return _getHolidayByIdFromCache(id);
        }
      } else {
        return _getHolidayByIdFromCache(id);
      }
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get holiday: ${e.toString()}'),
      );
    }
  }

  /// Helper method to get holiday by ID from cache
  Future<Either<Failure, Holiday>> _getHolidayByIdFromCache(String id) async {
    try {
      final cachedHoliday = await _localDataSource.getHolidayById(id);
      return Right(cachedHoliday.toEntity());
    } on CacheException catch (e) {
      return Left(NotFoundFailure(message: 'Holiday not found: ${e.message}'));
    }
  }

  @override
  ResultFuture<bool> isHoliday(DateTime date) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final result = await _remoteDataSource.isHoliday(date);
          return Right(result);
        } on ServerException {
          return _isHolidayFromCache(date);
        }
      } else {
        return _isHolidayFromCache(date);
      }
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to check if date is holiday: ${e.toString()}',
        ),
      );
    }
  }

  /// Helper method to check if date is holiday from cache
  Future<Either<Failure, bool>> _isHolidayFromCache(DateTime date) async {
    try {
      final result = await _localDataSource.isHoliday(date);
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  ResultFuture<Holiday> createHoliday(Holiday holiday) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message: 'No internet connection. Cannot create holiday.',
          ),
        );
      }

      final holidayModel = HolidayModel.fromEntity(holiday);
      final createdHoliday = await _remoteDataSource.createHoliday(
        holidayModel,
      );

      await _localDataSource.cacheHoliday(createdHoliday);

      return Right(createdHoliday.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to create holiday: ${e.toString()}'),
      );
    }
  }

  @override
  ResultFuture<Holiday> updateHoliday(Holiday holiday) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message: 'No internet connection. Cannot update holiday.',
          ),
        );
      }

      final holidayModel = HolidayModel.fromEntity(holiday);
      final updatedHoliday = await _remoteDataSource.updateHoliday(
        holidayModel,
      );

      await _localDataSource.cacheHoliday(updatedHoliday);

      return Right(updatedHoliday.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to update holiday: ${e.toString()}'),
      );
    }
  }

  @override
  ResultVoid deleteHoliday(String id) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message: 'No internet connection. Cannot delete holiday.',
          ),
        );
      }

      await _remoteDataSource.deleteHoliday(id);
      await _localDataSource.deleteHoliday(id);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to delete holiday: ${e.toString()}'),
      );
    }
  }
}
