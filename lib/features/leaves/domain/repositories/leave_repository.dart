import '../../../../core/utils/typedef.dart';
import '../entities/leave_type.dart';
import '../entities/leave_request.dart';
import '../entities/leave_balance.dart';

/// Leave repository interface
abstract class LeaveRepository {
  // Leave types
  ResultFuture<List<LeaveType>> getLeaveTypes();
  
  ResultFuture<LeaveType> getLeaveTypeById(String id);
  
  ResultFuture<void> createLeaveType(LeaveType leaveType);
  
  ResultFuture<void> updateLeaveType(LeaveType leaveType);
  
  ResultFuture<void> deleteLeaveType(String id);
  
  // Leave requests
  ResultFuture<List<LeaveRequest>> getLeaveRequests({
    String? employeeId,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    int? page,
    int? limit,
  });
  
  ResultFuture<LeaveRequest> getLeaveRequestById(String id);
  
  ResultFuture<void> createLeaveRequest(LeaveRequest request);
  
  ResultFuture<void> updateLeaveRequest(LeaveRequest request);
  
  ResultFuture<void> approveLeaveRequest({
    required String requestId,
    required String approverId,
    String? notes,
  });
  
  ResultFuture<void> rejectLeaveRequest({
    required String requestId,
    required String approverId,
    required String reason,
  });
  
  ResultFuture<void> cancelLeaveRequest(String requestId);
  
  ResultFuture<void> deleteLeaveRequest(String id);
  
  // Leave balance
  ResultFuture<List<LeaveBalance>> getLeaveBalances({
    required String employeeId,
    int? year,
  });
  
  ResultFuture<LeaveBalance> getLeaveBalanceById(String id);
  
  ResultFuture<LeaveBalance?> getLeaveBalanceByEmployeeAndType({
    required String employeeId,
    required String leaveTypeId,
    required int year,
  });
  
  ResultFuture<void> updateLeaveBalance(LeaveBalance balance);
  
  ResultFuture<void> initializeLeaveBalances({
    required String employeeId,
    required int year,
  });
}

