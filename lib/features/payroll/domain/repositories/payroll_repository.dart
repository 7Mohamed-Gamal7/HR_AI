import '../../../../core/utils/typedef.dart';
import '../entities/payroll.dart';
import '../entities/salary_component.dart';

/// Payroll repository interface
abstract class PayrollRepository {
  // Payroll operations
  ResultFuture<List<Payroll>> getPayrolls({
    String? employeeId,
    int? month,
    int? year,
    String? status,
    int? page,
    int? limit,
  });
  
  ResultFuture<Payroll> getPayrollById(String id);
  
  ResultFuture<Payroll?> getPayrollByEmployeeAndPeriod({
    required String employeeId,
    required int month,
    required int year,
  });
  
  ResultFuture<void> generatePayroll({
    required String employeeId,
    required int month,
    required int year,
  });
  
  ResultFuture<void> generatePayrollForAll({
    required int month,
    required int year,
  });
  
  ResultFuture<void> createPayroll(Payroll payroll);
  
  ResultFuture<void> updatePayroll(Payroll payroll);
  
  ResultFuture<void> approvePayroll(String id);
  
  ResultFuture<void> markPayrollAsPaid({
    required String id,
    required DateTime paidDate,
    String? paymentMethod,
  });
  
  ResultFuture<void> deletePayroll(String id);
  
  ResultFuture<Map<String, dynamic>> getPayrollSummary({
    required int month,
    required int year,
  });
  
  // Salary components
  ResultFuture<List<SalaryComponent>> getSalaryComponents({
    String? employeeId,
    String? type,
    bool? isActive,
  });
  
  ResultFuture<SalaryComponent> getSalaryComponentById(String id);
  
  ResultFuture<void> createSalaryComponent(SalaryComponent component);
  
  ResultFuture<void> updateSalaryComponent(SalaryComponent component);
  
  ResultFuture<void> deleteSalaryComponent(String id);
  
  // Payslip generation
  ResultFuture<String> generatePayslipPdf(String payrollId);
}

