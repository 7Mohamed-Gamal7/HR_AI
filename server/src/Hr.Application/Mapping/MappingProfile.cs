using AutoMapper;
using Hr.Application.Dtos;
using Hr.Domain.Entities;

namespace Hr.Application.Mapping;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<Employee, EmployeeDto>();
        CreateMap<EmployeeDto, Employee>();
    }
}