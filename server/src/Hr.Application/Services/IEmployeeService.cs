using Hr.Application.Dtos;

namespace Hr.Application.Services;

public interface IEmployeeService
{
    Task<(IReadOnlyList<EmployeeDto> Items, int Total)> ListAsync(int page, int pageSize, string? search);
    Task<EmployeeDto?> GetAsync(int id);
    Task<EmployeeDto> CreateAsync(EmployeeDto dto);
    Task<EmployeeDto?> UpdateAsync(int id, EmployeeDto dto);
    Task<bool> DeleteAsync(int id);
}