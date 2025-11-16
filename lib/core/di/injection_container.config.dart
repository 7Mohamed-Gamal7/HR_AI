// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/attendance/data/datasources/attendance_local_datasource.dart'
    as _i673;
import '../../features/attendance/data/datasources/attendance_remote_datasource.dart'
    as _i425;
import '../../features/attendance/data/repositories/attendance_repository_impl.dart'
    as _i719;
import '../../features/attendance/domain/repositories/attendance_repository.dart'
    as _i477;
import '../../features/employees/data/datasources/employee_local_datasource.dart'
    as _i885;
import '../../features/employees/data/datasources/employee_remote_datasource.dart'
    as _i498;
import '../../features/employees/data/repositories/employee_repository_impl.dart'
    as _i274;
import '../../features/employees/domain/repositories/employee_repository.dart'
    as _i636;
import '../../features/employees/domain/usecases/create_employee.dart' as _i871;
import '../../features/employees/domain/usecases/get_employees.dart' as _i194;
import '../../features/leaves/data/datasources/leave_local_datasource.dart'
    as _i1042;
import '../../features/leaves/data/datasources/leave_remote_datasource.dart'
    as _i1054;
import '../../features/leaves/data/repositories/leave_repository_impl.dart'
    as _i408;
import '../../features/leaves/domain/repositories/leave_repository.dart'
    as _i388;
import '../database/database_config.dart' as _i352;
import '../database/database_service.dart' as _i711;
import '../database/sqlite_database_service.dart' as _i281;
import '../network/api_client.dart' as _i557;
import '../network/network_info.dart' as _i932;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final connectivityModule = _$ConnectivityModule();
    gh.lazySingleton<_i557.ApiClient>(() => _i557.ApiClient());
    gh.lazySingleton<_i895.Connectivity>(() => connectivityModule.connectivity);
    gh.lazySingleton<_i711.DatabaseService>(() => _i281.SQLiteDatabaseService(
        gh<_i352.DatabaseConfig>(instanceName: 'databaseConfig')));
    gh.lazySingleton<_i932.NetworkInfo>(
        () => _i932.NetworkInfoImpl(gh<_i895.Connectivity>()));
    gh.lazySingleton<_i673.AttendanceLocalDataSource>(
        () => _i673.AttendanceLocalDataSourceImpl(gh<_i711.DatabaseService>()));
    gh.lazySingleton<_i885.EmployeeLocalDataSource>(
        () => _i885.EmployeeLocalDataSourceImpl(gh<_i711.DatabaseService>()));
    gh.lazySingleton<_i1054.LeaveRemoteDataSource>(
        () => _i1054.LeaveRemoteDataSourceImpl(gh<_i557.ApiClient>()));
    gh.lazySingleton<_i498.EmployeeRemoteDataSource>(
        () => _i498.EmployeeRemoteDataSourceImpl(gh<_i557.ApiClient>()));
    gh.lazySingleton<_i425.AttendanceRemoteDataSource>(
        () => _i425.AttendanceRemoteDataSourceImpl(gh<_i557.ApiClient>()));
    gh.lazySingleton<_i1042.LeaveLocalDataSource>(
        () => _i1042.LeaveLocalDataSourceImpl(gh<_i711.DatabaseService>()));
    gh.lazySingleton<_i636.EmployeeRepository>(
        () => _i274.EmployeeRepositoryImpl(
              gh<_i498.EmployeeRemoteDataSource>(),
              gh<_i885.EmployeeLocalDataSource>(),
              gh<_i932.NetworkInfo>(),
            ));
    gh.lazySingleton<_i477.AttendanceRepository>(
        () => _i719.AttendanceRepositoryImpl(
              gh<_i425.AttendanceRemoteDataSource>(),
              gh<_i673.AttendanceLocalDataSource>(),
              gh<_i932.NetworkInfo>(),
            ));
    gh.lazySingleton<_i871.CreateEmployee>(
        () => _i871.CreateEmployee(gh<_i636.EmployeeRepository>()));
    gh.lazySingleton<_i194.GetEmployees>(
        () => _i194.GetEmployees(gh<_i636.EmployeeRepository>()));
    gh.lazySingleton<_i388.LeaveRepository>(() => _i408.LeaveRepositoryImpl(
          gh<_i1054.LeaveRemoteDataSource>(),
          gh<_i1042.LeaveLocalDataSource>(),
          gh<_i932.NetworkInfo>(),
        ));
    return this;
  }
}

class _$ConnectivityModule extends _i932.ConnectivityModule {}
