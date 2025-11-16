import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/entities/leave_type.dart';
import '../../domain/entities/leave_request.dart';
import '../../domain/entities/leave_balance.dart';
import '../../domain/repositories/leave_repository.dart';
import '../datasources/leave_local_datasource.dart';
import '../datasources/leave_remote_datasource.dart';
import '../models/leave_type_model.dart';
import '../models/leave_request_model.dart';
import '../models/leave_balance_model.dart';

/// Implementation of leave repository with offline-first architecture
@LazySingleton(as: LeaveRepository)
class LeaveRepositoryImpl implements LeaveRepository {
  final LeaveRemoteDataSource _remoteDataSource;
  final LeaveLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  LeaveRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  // ==================== Leave Type Operations ====================

  @override
  ResultFuture<List<LeaveType>> getLeaveTypes() async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteTypes = await _remoteDataSource.getLeaveTypes();
          await _localDataSource.cacheLeaveTypes(remoteTypes);
          final types = remoteTypes.map((model) => model.toEntity()).toList();
          return Right(types);
        } on ServerException {
          return _getLeaveTypesFromCache();
        }
      } else {
        return _getLeaveTypesFromCache();
      }
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get leave types: ${e.toString()}'),
      );
    }
  }

  /// Helper method to get leave types from cache
  Future<Either<Failure, List<LeaveType>>> _getLeaveTypesFromCache() async {
    try {
      final cachedTypes = await _localDataSource.getLeaveTypes();
      final types = cachedTypes.map((model) => model.toEntity()).toList();
      return Right(types);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  ResultFuture<LeaveType> getLeaveTypeById(String id) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteType = await _remoteDataSource.getLeaveTypeById(id);
          await _localDataSource.cacheLeaveType(remoteType);
          return Right(remoteType.toEntity());
        } on ServerException {
          return _getLeaveTypeByIdFromCache(id);
        }
      } else {
        return _getLeaveTypeByIdFromCache(id);
      }
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get leave type: ${e.toString()}'),
      );
    }
  }

  /// Helper method to get leave type by ID from cache
  Future<Either<Failure, LeaveType>> _getLeaveTypeByIdFromCache(
    String id,
  ) async {
    try {
      final cachedType = await _localDataSource.getLeaveTypeById(id);
      return Right(cachedType.toEntity());
    } on CacheException catch (e) {
      return Left(
        NotFoundFailure(message: 'Leave type not found: ${e.message}'),
      );
    }
  }

  @override
  ResultVoid createLeaveType(LeaveType leaveType) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message: 'No internet connection. Cannot create leave type.',
          ),
        );
      }

      final typeModel = LeaveTypeModel.fromEntity(leaveType);
      final createdType = await _remoteDataSource.createLeaveType(typeModel);
      await _localDataSource.cacheLeaveType(createdType);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to create leave type: ${e.toString()}'),
      );
    }
  }

  @override
  ResultVoid updateLeaveType(LeaveType leaveType) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message: 'No internet connection. Cannot update leave type.',
          ),
        );
      }

      final typeModel = LeaveTypeModel.fromEntity(leaveType);
      final updatedType = await _remoteDataSource.updateLeaveType(typeModel);
      await _localDataSource.cacheLeaveType(updatedType);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to update leave type: ${e.toString()}'),
      );
    }
  }

  @override
  ResultVoid deleteLeaveType(String id) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message: 'No internet connection. Cannot delete leave type.',
          ),
        );
      }

      await _remoteDataSource.deleteLeaveType(id);
      await _localDataSource.deleteLeaveType(id);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to delete leave type: ${e.toString()}'),
      );
    }
  }

  // ==================== Leave Request Operations ====================

  @override
  ResultFuture<List<LeaveRequest>> getLeaveRequests({
    String? employeeId,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    int? page,
    int? limit,
  }) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteRequests = await _remoteDataSource.getLeaveRequests(
            employeeId: employeeId,
            status: status,
            startDate: startDate,
            endDate: endDate,
            page: page,
            limit: limit,
          );

          await _localDataSource.cacheLeaveRequests(remoteRequests);

          final requests =
              remoteRequests.map((model) => model.toEntity()).toList();
          return Right(requests);
        } on ServerException {
          return _getLeaveRequestsFromCache(
            employeeId: employeeId,
            status: status,
            startDate: startDate,
            endDate: endDate,
          );
        }
      } else {
        return _getLeaveRequestsFromCache(
          employeeId: employeeId,
          status: status,
          startDate: startDate,
          endDate: endDate,
        );
      }
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get leave requests: ${e.toString()}'),
      );
    }
  }

  /// Helper method to get leave requests from cache
  Future<Either<Failure, List<LeaveRequest>>> _getLeaveRequestsFromCache({
    String? employeeId,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final cachedRequests = await _localDataSource.getLeaveRequests(
        employeeId: employeeId,
        status: status,
        startDate: startDate,
        endDate: endDate,
      );

      final requests = cachedRequests.map((model) => model.toEntity()).toList();
      return Right(requests);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  ResultFuture<LeaveRequest> getLeaveRequestById(String id) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteRequest = await _remoteDataSource.getLeaveRequestById(id);
          await _localDataSource.cacheLeaveRequest(remoteRequest);
          return Right(remoteRequest.toEntity());
        } on ServerException {
          return _getLeaveRequestByIdFromCache(id);
        }
      } else {
        return _getLeaveRequestByIdFromCache(id);
      }
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get leave request: ${e.toString()}'),
      );
    }
  }

  /// Helper method to get leave request by ID from cache
  Future<Either<Failure, LeaveRequest>> _getLeaveRequestByIdFromCache(
    String id,
  ) async {
    try {
      final cachedRequest = await _localDataSource.getLeaveRequestById(id);
      return Right(cachedRequest.toEntity());
    } on CacheException catch (e) {
      return Left(
        NotFoundFailure(message: 'Leave request not found: ${e.message}'),
      );
    }
  }

  @override
  ResultVoid createLeaveRequest(LeaveRequest request) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message: 'No internet connection. Cannot create leave request.',
          ),
        );
      }

      final requestModel = LeaveRequestModel.fromEntity(request);
      final createdRequest = await _remoteDataSource.createLeaveRequest(
        requestModel,
      );
      await _localDataSource.cacheLeaveRequest(createdRequest);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to create leave request: ${e.toString()}',
        ),
      );
    }
  }

  @override
  ResultVoid updateLeaveRequest(LeaveRequest request) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message: 'No internet connection. Cannot update leave request.',
          ),
        );
      }

      final requestModel = LeaveRequestModel.fromEntity(request);
      final updatedRequest = await _remoteDataSource.updateLeaveRequest(
        requestModel,
      );
      await _localDataSource.cacheLeaveRequest(updatedRequest);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to update leave request: ${e.toString()}',
        ),
      );
    }
  }

  @override
  ResultVoid approveLeaveRequest({
    required String requestId,
    required String approverId,
    String? notes,
  }) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message: 'No internet connection. Cannot approve leave request.',
          ),
        );
      }

      final approvedRequest = await _remoteDataSource.approveLeaveRequest(
        requestId: requestId,
        approverId: approverId,
        notes: notes,
      );
      await _localDataSource.cacheLeaveRequest(approvedRequest);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to approve leave request: ${e.toString()}',
        ),
      );
    }
  }

  @override
  ResultVoid rejectLeaveRequest({
    required String requestId,
    required String approverId,
    required String reason,
  }) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message: 'No internet connection. Cannot reject leave request.',
          ),
        );
      }

      final rejectedRequest = await _remoteDataSource.rejectLeaveRequest(
        requestId: requestId,
        approverId: approverId,
        reason: reason,
      );
      await _localDataSource.cacheLeaveRequest(rejectedRequest);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to reject leave request: ${e.toString()}',
        ),
      );
    }
  }

  @override
  ResultVoid cancelLeaveRequest(String requestId) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message: 'No internet connection. Cannot cancel leave request.',
          ),
        );
      }

      final cancelledRequest = await _remoteDataSource.cancelLeaveRequest(
        requestId,
      );
      await _localDataSource.cacheLeaveRequest(cancelledRequest);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to cancel leave request: ${e.toString()}',
        ),
      );
    }
  }

  @override
  ResultVoid deleteLeaveRequest(String id) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message: 'No internet connection. Cannot delete leave request.',
          ),
        );
      }

      await _remoteDataSource.deleteLeaveRequest(id);
      await _localDataSource.deleteLeaveRequest(id);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to delete leave request: ${e.toString()}',
        ),
      );
    }
  }

  // ==================== Leave Balance Operations ====================

  @override
  ResultFuture<List<LeaveBalance>> getLeaveBalances({
    required String employeeId,
    int? year,
  }) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteBalances = await _remoteDataSource.getLeaveBalances(
            employeeId: employeeId,
            year: year,
          );

          await _localDataSource.cacheLeaveBalances(remoteBalances);

          final balances =
              remoteBalances.map((model) => model.toEntity()).toList();
          return Right(balances);
        } on ServerException {
          return _getLeaveBalancesFromCache(employeeId: employeeId, year: year);
        }
      } else {
        return _getLeaveBalancesFromCache(employeeId: employeeId, year: year);
      }
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get leave balances: ${e.toString()}'),
      );
    }
  }

  /// Helper method to get leave balances from cache
  Future<Either<Failure, List<LeaveBalance>>> _getLeaveBalancesFromCache({
    required String employeeId,
    int? year,
  }) async {
    try {
      final cachedBalances = await _localDataSource.getLeaveBalances(
        employeeId: employeeId,
        year: year,
      );

      final balances = cachedBalances.map((model) => model.toEntity()).toList();
      return Right(balances);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  ResultFuture<LeaveBalance> getLeaveBalanceById(String id) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteBalance = await _remoteDataSource.getLeaveBalanceById(id);
          await _localDataSource.cacheLeaveBalance(remoteBalance);
          return Right(remoteBalance.toEntity());
        } on ServerException {
          return _getLeaveBalanceByIdFromCache(id);
        }
      } else {
        return _getLeaveBalanceByIdFromCache(id);
      }
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get leave balance: ${e.toString()}'),
      );
    }
  }

  /// Helper method to get leave balance by ID from cache
  Future<Either<Failure, LeaveBalance>> _getLeaveBalanceByIdFromCache(
    String id,
  ) async {
    try {
      final cachedBalance = await _localDataSource.getLeaveBalanceById(id);
      return Right(cachedBalance.toEntity());
    } on CacheException catch (e) {
      return Left(
        NotFoundFailure(message: 'Leave balance not found: ${e.message}'),
      );
    }
  }

  @override
  ResultFuture<LeaveBalance?> getLeaveBalanceByEmployeeAndType({
    required String employeeId,
    required String leaveTypeId,
    required int year,
  }) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        try {
          final remoteBalance =
              await _remoteDataSource.getLeaveBalanceByEmployeeAndType(
            employeeId: employeeId,
            leaveTypeId: leaveTypeId,
            year: year,
          );

          if (remoteBalance != null) {
            await _localDataSource.cacheLeaveBalance(remoteBalance);
            return Right(remoteBalance.toEntity());
          }
          return const Right(null);
        } on ServerException {
          return _getLeaveBalanceByEmployeeAndTypeFromCache(
            employeeId: employeeId,
            leaveTypeId: leaveTypeId,
            year: year,
          );
        }
      } else {
        return _getLeaveBalanceByEmployeeAndTypeFromCache(
          employeeId: employeeId,
          leaveTypeId: leaveTypeId,
          year: year,
        );
      }
    } catch (e) {
      return Left(
        ServerFailure(
          message:
              'Failed to get leave balance by employee and type: ${e.toString()}',
        ),
      );
    }
  }

  /// Helper method to get leave balance by employee and type from cache
  Future<Either<Failure, LeaveBalance?>>
      _getLeaveBalanceByEmployeeAndTypeFromCache({
    required String employeeId,
    required String leaveTypeId,
    required int year,
  }) async {
    try {
      final cachedBalance =
          await _localDataSource.getLeaveBalanceByEmployeeAndType(
        employeeId: employeeId,
        leaveTypeId: leaveTypeId,
        year: year,
      );
      return Right(cachedBalance?.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  ResultVoid updateLeaveBalance(LeaveBalance balance) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message: 'No internet connection. Cannot update leave balance.',
          ),
        );
      }

      final balanceModel = LeaveBalanceModel.fromEntity(balance);
      final updatedBalance = await _remoteDataSource.updateLeaveBalance(
        balanceModel,
      );
      await _localDataSource.cacheLeaveBalance(updatedBalance);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to update leave balance: ${e.toString()}',
        ),
      );
    }
  }

  @override
  ResultVoid initializeLeaveBalances({
    required String employeeId,
    required int year,
  }) async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(
          NetworkFailure(
            message:
                'No internet connection. Cannot initialize leave balances.',
          ),
        );
      }

      final balances = await _remoteDataSource.initializeLeaveBalances(
        employeeId: employeeId,
        year: year,
      );
      await _localDataSource.cacheLeaveBalances(balances);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to initialize leave balances: ${e.toString()}',
        ),
      );
    }
  }
}
