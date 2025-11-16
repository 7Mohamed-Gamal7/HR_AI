using AutoMapper;
using AutoMapper.QueryableExtensions;
using Hr.Application.Dtos;
using Hr.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace Hr.Application.Services;

public class EmployeeService : IEmployeeService
{
    private readonly HrDbContext _db;
    private readonly IMapper _mapper;

    public EmployeeService(HrDbContext db, IMapper mapper)
    {
        _db = db;
        _mapper = mapper;
    }

    public async Task<(IReadOnlyList<EmployeeDto> Items, int Total)> ListAsync(int page, int pageSize, string? search)
    {
        var query = _db.Employees.AsNoTracking();
        if (!string.IsNullOrWhiteSpace(search))
        {
            query = query.Where(x => x.FullName.Contains(search) || x.EmployeeNumber.Contains(search));
        }
        var total = await query.CountAsync();
        var items = await query
            .OrderBy(x => x.FullName)
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .ProjectTo<EmployeeDto>(_mapper.ConfigurationProvider)
            .ToListAsync();
        return (items, total);
    }

    public async Task<EmployeeDto?> GetAsync(int id)
    {
        var e = await _db.Employees.AsNoTracking().FirstOrDefaultAsync(x => x.Id == id);
        return e == null ? null : _mapper.Map<EmployeeDto>(e);
    }

    public async Task<EmployeeDto> CreateAsync(EmployeeDto dto)
    {
        var entity = _mapper.Map<Hr.Domain.Entities.Employee>(dto);
        entity.Id = 0;
        entity.CreatedAt = DateTime.UtcNow;
        entity.UpdatedAt = DateTime.UtcNow;
        _db.Employees.Add(entity);
        await _db.SaveChangesAsync();
        return _mapper.Map<EmployeeDto>(entity);
    }

    public async Task<EmployeeDto?> UpdateAsync(int id, EmployeeDto dto)
    {
        var entity = await _db.Employees.FirstOrDefaultAsync(x => x.Id == id);
        if (entity == null) return null;
        entity.EmployeeNumber = dto.EmployeeNumber;
        entity.FirstName = dto.FirstName;
        entity.LastName = dto.LastName;
        entity.FullName = dto.FullName;
        entity.Email = dto.Email;
        entity.Phone = dto.Phone;
        entity.DepartmentId = dto.DepartmentId;
        entity.JobTitleId = dto.JobTitleId;
        entity.HireDate = dto.HireDate;
        entity.Salary = dto.Salary;
        entity.Status = dto.Status;
        entity.UpdatedAt = DateTime.UtcNow;
        await _db.SaveChangesAsync();
        return _mapper.Map<EmployeeDto>(entity);
    }

    public async Task<bool> DeleteAsync(int id)
    {
        var entity = await _db.Employees.FirstOrDefaultAsync(x => x.Id == id);
        if (entity == null) return false;
        _db.Employees.Remove(entity);
        await _db.SaveChangesAsync();
        return true;
    }
}