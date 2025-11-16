import 'package:injectable/injectable.dart';
import '../../../../core/database/database_service.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/attendance_model.dart';
import '../models/attendance_rule_model.dart';
import '../models/holiday_model.dart';

/// Abstract interface for attendance local data source
abstract class AttendanceLocalDataSource {
  // Attendance operations
  Future<List<AttendanceModel>> getAttendances({
    String? employeeId,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    int? limit,
    int? offset,
  });

  Future<AttendanceModel> getAttendanceById(String id);
  Future<AttendanceModel?> getAttendanceByEmployeeAndDate(
    String employeeId,
    DateTime date,
  );
  Future<void> cacheAttendances(List<AttendanceModel> attendances);
  Future<void> cacheAttendance(AttendanceModel attendance);
  Future<void> deleteAttendance(String id);
  Future<void> clearAttendances();

  // Attendance Rule operations
  Future<List<AttendanceRuleModel>> getAttendanceRules({bool? isActive});
  Future<AttendanceRuleModel> getAttendanceRuleById(String id);
  Future<AttendanceRuleModel?> getDefaultAttendanceRule();
  Future<AttendanceRuleModel?> getAttendanceRuleForEmployee(String employeeId);
  Future<AttendanceRuleModel?> getAttendanceRuleForDepartment(
    String departmentId,
  );
  Future<void> cacheAttendanceRules(List<AttendanceRuleModel> rules);
  Future<void> cacheAttendanceRule(AttendanceRuleModel rule);
  Future<void> deleteAttendanceRule(String id);

  // Holiday operations
  Future<List<HolidayModel>> getHolidays({
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
  });
  Future<HolidayModel> getHolidayById(String id);
  Future<bool> isHoliday(DateTime date);
  Future<void> cacheHolidays(List<HolidayModel> holidays);
  Future<void> cacheHoliday(HolidayModel holiday);
  Future<void> deleteHoliday(String id);
}

/// Implementation of attendance local data source using SQLite
@LazySingleton(as: AttendanceLocalDataSource)
class AttendanceLocalDataSourceImpl implements AttendanceLocalDataSource {
  final DatabaseService _databaseService;

  AttendanceLocalDataSourceImpl(this._databaseService);

  // ==================== Attendance Operations ====================

  @override
  Future<List<AttendanceModel>> getAttendances({
    String? employeeId,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    int? limit,
    int? offset,
  }) async {
    try {
      final whereConditions = <String>[];
      final whereArgs = <dynamic>[];

      if (employeeId != null) {
        whereConditions.add('a.employee_id = ?');
        whereArgs.add(employeeId);
      }

      if (startDate != null) {
        whereConditions.add('a.date >= ?');
        whereArgs.add(startDate.toIso8601String().split('T')[0]);
      }

      if (endDate != null) {
        whereConditions.add('a.date <= ?');
        whereArgs.add(endDate.toIso8601String().split('T')[0]);
      }

      if (status != null) {
        whereConditions.add('a.status = ?');
        whereArgs.add(status);
      }

      final whereClause = whereConditions.isNotEmpty
          ? 'WHERE ${whereConditions.join(' AND ')}'
          : '';

      final limitClause = limit != null ? 'LIMIT $limit' : '';
      final offsetClause = offset != null ? 'OFFSET $offset' : '';

      final sql = '''
        SELECT 
          a.*,
          e.full_name as employee_name
        FROM attendance a
        LEFT JOIN employees e ON a.employee_id = e.id
        $whereClause
        ORDER BY a.date DESC, a.check_in_time DESC
        $limitClause $offsetClause
      ''';

      final results = await _databaseService.query(sql, arguments: whereArgs);
      return results.map((map) => AttendanceModel.fromDatabase(map)).toList();
    } catch (e) {
      throw CacheException(
        message: 'Failed to get attendances from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<AttendanceModel> getAttendanceById(String id) async {
    try {
      const sql = '''
        SELECT 
          a.*,
          e.full_name as employee_name
        FROM attendance a
        LEFT JOIN employees e ON a.employee_id = e.id
        WHERE a.id = ?
      ''';

      final results = await _databaseService.query(sql, arguments: [id]);

      if (results.isEmpty) {
        throw const CacheException(message: 'Attendance not found in cache');
      }

      return AttendanceModel.fromDatabase(results.first);
    } catch (e) {
      throw CacheException(
        message: 'Failed to get attendance from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<AttendanceModel?> getAttendanceByEmployeeAndDate(
    String employeeId,
    DateTime date,
  ) async {
    try {
      final dateString = date.toIso8601String().split('T')[0];
      const sql = '''
        SELECT 
          a.*,
          e.full_name as employee_name
        FROM attendance a
        LEFT JOIN employees e ON a.employee_id = e.id
        WHERE a.employee_id = ? AND a.date = ?
      ''';

      final results = await _databaseService.query(
        sql,
        arguments: [employeeId, dateString],
      );

      if (results.isEmpty) {
        return null;
      }

      return AttendanceModel.fromDatabase(results.first);
    } catch (e) {
      throw CacheException(
        message: 'Failed to get attendance from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cacheAttendances(List<AttendanceModel> attendances) async {
    try {
      for (final attendance in attendances) {
        await cacheAttendance(attendance);
      }
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache attendances: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cacheAttendance(AttendanceModel attendance) async {
    try {
      await _databaseService.insert(
        'attendance',
        attendance.toDatabase(),
        conflictAlgorithm: 'REPLACE',
      );
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache attendance: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteAttendance(String id) async {
    try {
      await _databaseService.delete(
        'attendance',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw CacheException(
        message: 'Failed to delete attendance from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> clearAttendances() async {
    try {
      await _databaseService.delete('attendance');
    } catch (e) {
      throw CacheException(
        message: 'Failed to clear attendances from cache: ${e.toString()}',
      );
    }
  }

  // ==================== Attendance Rule Operations ====================

  @override
  Future<List<AttendanceRuleModel>> getAttendanceRules({bool? isActive}) async {
    try {
      final whereClause = isActive != null ? 'WHERE is_active = ?' : '';
      final whereArgs = isActive != null ? [isActive ? 1 : 0] : null;

      final sql = '''
        SELECT * FROM attendance_rules
        $whereClause
        ORDER BY is_default DESC, name ASC
      ''';

      final results = await _databaseService.query(sql, arguments: whereArgs);
      return results
          .map((map) => AttendanceRuleModel.fromDatabase(map))
          .toList();
    } catch (e) {
      throw CacheException(
        message: 'Failed to get attendance rules from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<AttendanceRuleModel> getAttendanceRuleById(String id) async {
    try {
      final results = await _databaseService.query(
        'SELECT * FROM attendance_rules WHERE id = ?',
        arguments: [id],
      );

      if (results.isEmpty) {
        throw const CacheException(
            message: 'Attendance rule not found in cache');
      }

      return AttendanceRuleModel.fromDatabase(results.first);
    } catch (e) {
      throw CacheException(
        message: 'Failed to get attendance rule from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<AttendanceRuleModel?> getDefaultAttendanceRule() async {
    try {
      final results = await _databaseService.query(
        'SELECT * FROM attendance_rules WHERE is_default = 1 AND is_active = 1',
      );

      if (results.isEmpty) {
        return null;
      }

      return AttendanceRuleModel.fromDatabase(results.first);
    } catch (e) {
      throw CacheException(
        message: 'Failed to get default attendance rule: ${e.toString()}',
      );
    }
  }

  @override
  Future<AttendanceRuleModel?> getAttendanceRuleForEmployee(
    String employeeId,
  ) async {
    try {
      final results = await _databaseService.query(
        'SELECT * FROM attendance_rules WHERE employee_id = ? AND is_active = 1',
        arguments: [employeeId],
      );

      if (results.isEmpty) {
        return null;
      }

      return AttendanceRuleModel.fromDatabase(results.first);
    } catch (e) {
      throw CacheException(
        message: 'Failed to get attendance rule for employee: ${e.toString()}',
      );
    }
  }

  @override
  Future<AttendanceRuleModel?> getAttendanceRuleForDepartment(
    String departmentId,
  ) async {
    try {
      final results = await _databaseService.query(
        'SELECT * FROM attendance_rules WHERE department_id = ? AND is_active = 1',
        arguments: [departmentId],
      );

      if (results.isEmpty) {
        return null;
      }

      return AttendanceRuleModel.fromDatabase(results.first);
    } catch (e) {
      throw CacheException(
        message:
            'Failed to get attendance rule for department: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cacheAttendanceRules(List<AttendanceRuleModel> rules) async {
    try {
      for (final rule in rules) {
        await cacheAttendanceRule(rule);
      }
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache attendance rules: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cacheAttendanceRule(AttendanceRuleModel rule) async {
    try {
      await _databaseService.insert(
        'attendance_rules',
        rule.toDatabase(),
        conflictAlgorithm: 'REPLACE',
      );
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache attendance rule: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteAttendanceRule(String id) async {
    try {
      await _databaseService.delete(
        'attendance_rules',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw CacheException(
        message: 'Failed to delete attendance rule from cache: ${e.toString()}',
      );
    }
  }

  // ==================== Holiday Operations ====================

  @override
  Future<List<HolidayModel>> getHolidays({
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
  }) async {
    try {
      final whereConditions = <String>[];
      final whereArgs = <dynamic>[];

      if (startDate != null) {
        whereConditions.add('date >= ?');
        whereArgs.add(startDate.toIso8601String().split('T')[0]);
      }

      if (endDate != null) {
        whereConditions.add('date <= ?');
        whereArgs.add(endDate.toIso8601String().split('T')[0]);
      }

      if (isActive != null) {
        whereConditions.add('is_active = ?');
        whereArgs.add(isActive ? 1 : 0);
      }

      final whereClause = whereConditions.isNotEmpty
          ? 'WHERE ${whereConditions.join(' AND ')}'
          : '';

      final sql = '''
        SELECT * FROM holidays
        $whereClause
        ORDER BY date ASC
      ''';

      final results = await _databaseService.query(sql, arguments: whereArgs);
      return results.map((map) => HolidayModel.fromDatabase(map)).toList();
    } catch (e) {
      throw CacheException(
        message: 'Failed to get holidays from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<HolidayModel> getHolidayById(String id) async {
    try {
      final results = await _databaseService.query(
        'SELECT * FROM holidays WHERE id = ?',
        arguments: [id],
      );

      if (results.isEmpty) {
        throw const CacheException(message: 'Holiday not found in cache');
      }

      return HolidayModel.fromDatabase(results.first);
    } catch (e) {
      throw CacheException(
        message: 'Failed to get holiday from cache: ${e.toString()}',
      );
    }
  }

  @override
  Future<bool> isHoliday(DateTime date) async {
    try {
      final dateString = date.toIso8601String().split('T')[0];
      const sql = '''
        SELECT COUNT(*) as count FROM holidays
        WHERE is_active = 1
        AND date <= ?
        AND (end_date IS NULL OR end_date >= ?)
      ''';

      final results = await _databaseService.query(
        sql,
        arguments: [dateString, dateString],
      );

      final count = results.first['count'] as int;
      return count > 0;
    } catch (e) {
      throw CacheException(
        message: 'Failed to check if date is holiday: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cacheHolidays(List<HolidayModel> holidays) async {
    try {
      for (final holiday in holidays) {
        await cacheHoliday(holiday);
      }
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache holidays: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cacheHoliday(HolidayModel holiday) async {
    try {
      await _databaseService.insert(
        'holidays',
        holiday.toDatabase(),
        conflictAlgorithm: 'REPLACE',
      );
    } catch (e) {
      throw CacheException(message: 'Failed to cache holiday: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteHoliday(String id) async {
    try {
      await _databaseService.delete(
        'holidays',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw CacheException(
        message: 'Failed to delete holiday from cache: ${e.toString()}',
      );
    }
  }
}
