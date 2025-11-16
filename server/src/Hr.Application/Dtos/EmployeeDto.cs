namespace Hr.Application.Dtos;

public record EmployeeDto(
    int Id,
    string EmployeeNumber,
    string FirstName,
    string LastName,
    string FullName,
    string? Email,
    string? Phone,
    int? DepartmentId,
    int? JobTitleId,
    DateTime? HireDate,
    decimal? Salary,
    string Status,
    DateTime CreatedAt,
    DateTime UpdatedAt
);