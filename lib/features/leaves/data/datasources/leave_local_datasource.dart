import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../core/database/database_service.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/leave_type_model.dart';
import '../models/leave_request_model.dart';
import '../models/leave_balance_model.dart';

/// Abstract interface for leave local data source
abstract class LeaveLocalDataSource {
  // Leave Type operations
  Future<List<LeaveTypeModel>> getLeaveTypes({bool? isActive});
  Future<LeaveTypeModel> getLeaveTypeById(String id);
  Future<void> cacheLeaveTypes(List<LeaveTypeModel> leaveTypes);
  Future<void> cacheLeaveType(LeaveTypeModel leaveType);
  Future<void> deleteLeaveType(String id);

  // Leave Request operations
  Future<List<LeaveRequestModel>> getLeaveRequests({
    String? employeeId,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<LeaveRequestModel> getLeaveRequestById(String id);
  Future<void> cacheLeaveRequests(List<LeaveRequestModel> requests);
  Future<void> cacheLeaveRequest(LeaveRequestModel request);
  Future<void> deleteLeaveRequest(String id);
  Future<void> clearLeaveRequests();

  // Leave Balance operations
  Future<List<LeaveBalanceModel>> getLeaveBalances({
    required String employeeId,
    int? year,
  });
  Future<LeaveBalanceModel> getLeaveBalanceById(String id);
  Future<LeaveBalanceModel?> getLeaveBalanceByEmployeeAndType({
    required String employeeId,
    required String leaveTypeId,
    required int year,
  });
  Future<void> cacheLeaveBalances(List<LeaveBalanceModel> balances);
  Future<void> cacheLeaveBalance(LeaveBalanceModel balance);
  Future<void> deleteLeaveBalance(String id);
}

/// Implementation of leave local data source using SQLite
@LazySingleton(as: LeaveLocalDataSource)
class LeaveLocalDataSourceImpl implements LeaveLocalDataSource {
  final DatabaseService _databaseService;

  LeaveLocalDataSourceImpl(this._databaseService);

  // ==================== Leave Type Operations ====================

  @override
  Future<List<LeaveTypeModel>> getLeaveTypes({bool? isActive}) async {
    try {
      final db = await _databaseService.database;

      final sql = '''
        SELECT * FROM leave_types
        ${isActive != null ? 'WHERE is_active = ?' : ''}
        ORDER BY name ASC
      ''';

      final params = isActive != null ? [isActive ? 1 : 0] : null;
      final results = await db.query(
        'leave_types',
        where: isActive != null ? 'is_active = ?' : null,
        whereArgs: params,
        orderBy: 'name ASC',
      );

      return results.map((map) => LeaveTypeModel.fromDatabase(map)).toList();
    } catch (e) {
      throw CacheException(
        message: 'Failed to get leave types from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<LeaveTypeModel> getLeaveTypeById(String id) async {
    try {
      final db = await _databaseService.database;

      final results = await db.query(
        'leave_types',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (results.isEmpty) {
        throw const CacheException(message: 'Leave type not found in cache');
      }

      return LeaveTypeModel.fromDatabase(results.first);
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(
        message: 'Failed to get leave type from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cacheLeaveTypes(List<LeaveTypeModel> leaveTypes) async {
    try {
      final db = await _databaseService.database;

      await db.transaction((txn) async {
        for (final leaveType in leaveTypes) {
          await txn.insert(
            'leave_types',
            leaveType.toDatabase(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache leave types: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cacheLeaveType(LeaveTypeModel leaveType) async {
    try {
      final db = await _databaseService.database;

      await db.insert(
        'leave_types',
        leaveType.toDatabase(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache leave type: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteLeaveType(String id) async {
    try {
      final db = await _databaseService.database;

      await db.delete('leave_types', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw CacheException(
        message: 'Failed to delete leave type from cache: ${e.toString()}',
      );
    }
  }

  // ==================== Leave Request Operations ====================

  @override
  Future<List<LeaveRequestModel>> getLeaveRequests({
    String? employeeId,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final db = await _databaseService.database;

      final sql = '''
        SELECT 
          lr.*,
          e.first_name || ' ' || e.last_name as employee_name,
          lt.name as leave_type_name,
          a.first_name || ' ' || a.last_name as approver_name
        FROM leave_requests lr
        LEFT JOIN employees e ON lr.employee_id = e.id
        LEFT JOIN leave_types lt ON lr.leave_type_id = lt.id
        LEFT JOIN employees a ON lr.approver_id = a.id
        WHERE 1=1
        ${employeeId != null ? 'AND lr.employee_id = ?' : ''}
        ${status != null ? 'AND lr.status = ?' : ''}
        ${startDate != null ? 'AND lr.start_date >= ?' : ''}
        ${endDate != null ? 'AND lr.end_date <= ?' : ''}
        ORDER BY lr.created_at DESC
      ''';

      final params = <dynamic>[];
      if (employeeId != null) params.add(employeeId);
      if (status != null) params.add(status);
      if (startDate != null) {
        params.add(startDate.toIso8601String().split('T')[0]);
      }
      if (endDate != null) params.add(endDate.toIso8601String().split('T')[0]);

      final results = await db.rawQuery(sql, params.isNotEmpty ? params : null);

      return results.map((map) => LeaveRequestModel.fromDatabase(map)).toList();
    } catch (e) {
      throw CacheException(
        message: 'Failed to get leave requests from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<LeaveRequestModel> getLeaveRequestById(String id) async {
    try {
      final db = await _databaseService.database;

      const sql = '''
        SELECT 
          lr.*,
          e.first_name || ' ' || e.last_name as employee_name,
          lt.name as leave_type_name,
          a.first_name || ' ' || a.last_name as approver_name
        FROM leave_requests lr
        LEFT JOIN employees e ON lr.employee_id = e.id
        LEFT JOIN leave_types lt ON lr.leave_type_id = lt.id
        LEFT JOIN employees a ON lr.approver_id = a.id
        WHERE lr.id = ?
        LIMIT 1
      ''';

      final results = await db.rawQuery(sql, [id]);

      if (results.isEmpty) {
        throw const CacheException(message: 'Leave request not found in cache');
      }

      return LeaveRequestModel.fromDatabase(results.first);
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(
        message: 'Failed to get leave request from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cacheLeaveRequests(List<LeaveRequestModel> requests) async {
    try {
      final db = await _databaseService.database;

      await db.transaction((txn) async {
        for (final request in requests) {
          await txn.insert(
            'leave_requests',
            request.toDatabase(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache leave requests: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cacheLeaveRequest(LeaveRequestModel request) async {
    try {
      final db = await _databaseService.database;

      await db.insert(
        'leave_requests',
        request.toDatabase(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache leave request: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteLeaveRequest(String id) async {
    try {
      final db = await _databaseService.database;

      await db.delete('leave_requests', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw CacheException(
        message: 'Failed to delete leave request from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> clearLeaveRequests() async {
    try {
      final db = await _databaseService.database;
      await db.delete('leave_requests');
    } catch (e) {
      throw CacheException(
        message: 'Failed to clear leave requests from cache: ${e.toString()}',
      );
    }
  }

  // ==================== Leave Balance Operations ====================

  @override
  Future<List<LeaveBalanceModel>> getLeaveBalances({
    required String employeeId,
    int? year,
  }) async {
    try {
      final db = await _databaseService.database;

      final sql = '''
        SELECT
          lb.*,
          e.first_name || ' ' || e.last_name as employee_name,
          lt.name as leave_type_name
        FROM leave_balances lb
        LEFT JOIN employees e ON lb.employee_id = e.id
        LEFT JOIN leave_types lt ON lb.leave_type_id = lt.id
        WHERE lb.employee_id = ?
        ${year != null ? 'AND lb.year = ?' : ''}
        ORDER BY lt.name ASC
      ''';

      final params = year != null ? [employeeId, year] : [employeeId];
      final results = await db.rawQuery(sql, params);

      return results.map((map) => LeaveBalanceModel.fromDatabase(map)).toList();
    } catch (e) {
      throw CacheException(
        message: 'Failed to get leave balances from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<LeaveBalanceModel> getLeaveBalanceById(String id) async {
    try {
      final db = await _databaseService.database;

      const sql = '''
        SELECT
          lb.*,
          e.first_name || ' ' || e.last_name as employee_name,
          lt.name as leave_type_name
        FROM leave_balances lb
        LEFT JOIN employees e ON lb.employee_id = e.id
        LEFT JOIN leave_types lt ON lb.leave_type_id = lt.id
        WHERE lb.id = ?
        LIMIT 1
      ''';

      final results = await db.rawQuery(sql, [id]);

      if (results.isEmpty) {
        throw const CacheException(message: 'Leave balance not found in cache');
      }

      return LeaveBalanceModel.fromDatabase(results.first);
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(
        message: 'Failed to get leave balance from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<LeaveBalanceModel?> getLeaveBalanceByEmployeeAndType({
    required String employeeId,
    required String leaveTypeId,
    required int year,
  }) async {
    try {
      final db = await _databaseService.database;

      const sql = '''
        SELECT
          lb.*,
          e.first_name || ' ' || e.last_name as employee_name,
          lt.name as leave_type_name
        FROM leave_balances lb
        LEFT JOIN employees e ON lb.employee_id = e.id
        LEFT JOIN leave_types lt ON lb.leave_type_id = lt.id
        WHERE lb.employee_id = ?
          AND lb.leave_type_id = ?
          AND lb.year = ?
        LIMIT 1
      ''';

      final results = await db.rawQuery(sql, [employeeId, leaveTypeId, year]);

      if (results.isEmpty) {
        return null;
      }

      return LeaveBalanceModel.fromDatabase(results.first);
    } catch (e) {
      throw CacheException(
        message:
            'Failed to get leave balance by employee and type from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cacheLeaveBalances(List<LeaveBalanceModel> balances) async {
    try {
      final db = await _databaseService.database;

      await db.transaction((txn) async {
        for (final balance in balances) {
          await txn.insert(
            'leave_balances',
            balance.toDatabase(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache leave balances: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cacheLeaveBalance(LeaveBalanceModel balance) async {
    try {
      final db = await _databaseService.database;

      await db.insert(
        'leave_balances',
        balance.toDatabase(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache leave balance: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteLeaveBalance(String id) async {
    try {
      final db = await _databaseService.database;

      await db.delete('leave_balances', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw CacheException(
        message: 'Failed to delete leave balance from cache: ${e.toString()}',
      );
    }
  }
}
