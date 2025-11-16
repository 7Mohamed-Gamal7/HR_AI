import '../../../../core/utils/typedef.dart';
import '../entities/attendance.dart';
import '../entities/attendance_rule.dart';
import '../entities/holiday.dart';

/// Attendance repository interface
abstract class AttendanceRepository {
  // Attendance operations
  ResultFuture<List<Attendance>> getAttendance({
    String? employeeId,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    int? page,
    int? limit,
  });
  
  ResultFuture<Attendance> getAttendanceById(String id);
  
  ResultFuture<Attendance?> getAttendanceByEmployeeAndDate(
    String employeeId,
    DateTime date,
  );
  
  ResultFuture<void> checkIn({
    required String employeeId,
    required DateTime checkInTime,
    String? method,
    String? location,
  });
  
  ResultFuture<void> checkOut({
    required String employeeId,
    required DateTime checkOutTime,
    String? method,
    String? location,
  });
  
  ResultFuture<void> createAttendance(Attendance attendance);
  
  ResultFuture<void> updateAttendance(Attendance attendance);
  
  ResultFuture<void> deleteAttendance(String id);
  
  ResultFuture<Map<String, dynamic>> getAttendanceSummary({
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
  });
  
  // Attendance rules
  ResultFuture<List<AttendanceRule>> getAttendanceRules();
  
  ResultFuture<AttendanceRule> getAttendanceRuleById(String id);
  
  ResultFuture<AttendanceRule?> getAttendanceRuleForEmployee(String employeeId);
  
  ResultFuture<void> createAttendanceRule(AttendanceRule rule);
  
  ResultFuture<void> updateAttendanceRule(AttendanceRule rule);
  
  ResultFuture<void> deleteAttendanceRule(String id);
  
  // Holidays
  ResultFuture<List<Holiday>> getHolidays({int? year});
  
  ResultFuture<Holiday> getHolidayById(String id);
  
  ResultFuture<bool> isHoliday(DateTime date);
  
  ResultFuture<void> createHoliday(Holiday holiday);
  
  ResultFuture<void> updateHoliday(Holiday holiday);
  
  ResultFuture<void> deleteHoliday(String id);
}

