import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:injectable/injectable.dart';
import '../errors/exceptions.dart';
import 'database_config.dart';
import 'database_service.dart';
import 'database_type.dart';

/// SQLite database service implementation
@LazySingleton(as: DatabaseService)
class SQLiteDatabaseService implements DatabaseService {
  Database? _database;
  final DatabaseConfig _config;

  SQLiteDatabaseService(@Named('databaseConfig') this._config) {
    if (_config.type != DatabaseType.sqlite) {
      throw DatabaseException(
        message: 'SQLiteDatabaseService requires SQLite configuration',
      );
    }
  }

  @override
  DatabaseConfig get config => _config;

  @override
  bool get isInitialized => _database != null && _database!.isOpen;

  /// Get the database instance
  Future<Database> get database async {
    if (_database != null && _database!.isOpen) {
      return _database!;
    }
    await initialize();
    return _database!;
  }

  @override
  Future<void> initialize() async {
    if (_database != null && _database!.isOpen) {
      return;
    }

    try {
      final Directory documentsDirectory =
          await getApplicationDocumentsDirectory();
      final String path = join(documentsDirectory.path, _config.databaseName);

      _database = await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onConfigure: _onConfigure,
      );
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to initialize SQLite database: ${e.toString()}',
      );
    }
  }

  /// Configure database settings
  Future<void> _onConfigure(Database db) async {
    // Enable foreign keys
    await db.execute('PRAGMA foreign_keys = ON');
  }

  /// Create database tables
  Future<void> _onCreate(Database db, int version) async {
    await _createTables(db);
  }

  /// Upgrade database schema
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database migrations here
    // For now, we'll just recreate tables (not recommended for production)
    if (newVersion > oldVersion) {
      // Add migration logic here
    }
  }

  /// Create all database tables
  Future<void> _createTables(Database db) async {
    // Users table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id TEXT PRIMARY KEY,
        username TEXT UNIQUE NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password_hash TEXT NOT NULL,
        salt TEXT NOT NULL,
        employee_id TEXT,
        is_active INTEGER DEFAULT 1,
        last_login DATETIME,
        created_at DATETIME NOT NULL,
        updated_at DATETIME,
        FOREIGN KEY (employee_id) REFERENCES employees(id)
      )
    ''');

    // Departments table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS departments (
        id TEXT PRIMARY KEY,
        name TEXT UNIQUE NOT NULL,
        description TEXT,
        manager_id TEXT,
        is_active INTEGER DEFAULT 1,
        created_at DATETIME NOT NULL,
        updated_at DATETIME,
        FOREIGN KEY (manager_id) REFERENCES employees(id)
      )
    ''');

    // Positions table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS positions (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        department_id TEXT NOT NULL,
        min_salary REAL,
        max_salary REAL,
        level INTEGER DEFAULT 1,
        is_active INTEGER DEFAULT 1,
        created_at DATETIME NOT NULL,
        updated_at DATETIME,
        FOREIGN KEY (department_id) REFERENCES departments(id)
      )
    ''');

    // Employees table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS employees (
        id TEXT PRIMARY KEY,
        employee_code TEXT UNIQUE NOT NULL,
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        middle_name TEXT,
        full_name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        phone TEXT NOT NULL,
        national_id TEXT UNIQUE,
        birth_date DATE,
        gender TEXT NOT NULL,
        marital_status TEXT NOT NULL,
        address TEXT,
        city TEXT,
        country TEXT,
        profile_image TEXT,
        department_id TEXT NOT NULL,
        position_id TEXT NOT NULL,
        hire_date DATE NOT NULL,
        employment_type TEXT NOT NULL,
        status TEXT NOT NULL DEFAULT 'active',
        basic_salary REAL NOT NULL,
        currency TEXT DEFAULT 'EGP',
        manager_id TEXT,
        emergency_contact_name TEXT,
        emergency_contact_phone TEXT,
        notes TEXT,
        created_at DATETIME NOT NULL,
        updated_at DATETIME,
        FOREIGN KEY (department_id) REFERENCES departments(id),
        FOREIGN KEY (position_id) REFERENCES positions(id),
        FOREIGN KEY (manager_id) REFERENCES employees(id)
      )
    ''');

    // Create indexes for employees
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_employees_department ON employees(department_id)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_employees_position ON employees(position_id)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_employees_status ON employees(status)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_employees_manager ON employees(manager_id)',
    );

    // Attendance rules table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS attendance_rules (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        work_days TEXT NOT NULL,
        work_start_time TIME NOT NULL,
        work_end_time TIME NOT NULL,
        work_hours_per_day INTEGER NOT NULL,
        late_minutes_allowed INTEGER DEFAULT 15,
        early_departure_minutes_allowed INTEGER DEFAULT 15,
        grace_minutes INTEGER DEFAULT 5,
        overtime_enabled INTEGER DEFAULT 1,
        overtime_start_after_minutes INTEGER DEFAULT 0,
        overtime_multiplier REAL DEFAULT 1.5,
        break_required INTEGER DEFAULT 1,
        break_duration_minutes INTEGER DEFAULT 60,
        break_paid INTEGER DEFAULT 0,
        department_id TEXT,
        employee_id TEXT,
        is_default INTEGER DEFAULT 0,
        is_active INTEGER DEFAULT 1,
        created_at DATETIME NOT NULL,
        updated_at DATETIME,
        FOREIGN KEY (department_id) REFERENCES departments(id),
        FOREIGN KEY (employee_id) REFERENCES employees(id)
      )
    ''');

    // Holidays table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS holidays (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        date DATE NOT NULL,
        end_date DATE,
        is_paid INTEGER DEFAULT 1,
        is_recurring INTEGER DEFAULT 0,
        country TEXT,
        is_active INTEGER DEFAULT 1,
        created_at DATETIME NOT NULL,
        updated_at DATETIME
      )
    ''');

    // Attendance table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS attendance (
        id TEXT PRIMARY KEY,
        employee_id TEXT NOT NULL,
        date DATE NOT NULL,
        check_in_time DATETIME,
        check_out_time DATETIME,
        status TEXT NOT NULL,
        work_duration INTEGER,
        late_duration INTEGER,
        early_departure_duration INTEGER,
        overtime_duration INTEGER,
        notes TEXT,
        check_in_method TEXT,
        check_out_method TEXT,
        check_in_location TEXT,
        check_out_location TEXT,
        created_at DATETIME NOT NULL,
        updated_at DATETIME,
        FOREIGN KEY (employee_id) REFERENCES employees(id),
        UNIQUE(employee_id, date)
      )
    ''');

    // Create indexes for attendance
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_attendance_employee ON attendance(employee_id)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_attendance_date ON attendance(date)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_attendance_status ON attendance(status)',
    );

    // Leave types table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS leave_types (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        code TEXT UNIQUE NOT NULL,
        description TEXT,
        default_days_per_year INTEGER NOT NULL,
        is_paid INTEGER DEFAULT 1,
        requires_approval INTEGER DEFAULT 1,
        requires_document INTEGER DEFAULT 0,
        max_consecutive_days INTEGER DEFAULT 30,
        min_days_notice INTEGER DEFAULT 1,
        can_carry_forward INTEGER DEFAULT 0,
        max_carry_forward_days INTEGER DEFAULT 0,
        color TEXT,
        is_active INTEGER DEFAULT 1,
        created_at DATETIME NOT NULL,
        updated_at DATETIME
      )
    ''');

    // Leave requests table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS leave_requests (
        id TEXT PRIMARY KEY,
        employee_id TEXT NOT NULL,
        leave_type_id TEXT NOT NULL,
        start_date DATE NOT NULL,
        end_date DATE NOT NULL,
        number_of_days INTEGER NOT NULL,
        reason TEXT NOT NULL,
        status TEXT NOT NULL DEFAULT 'pending',
        attachment_path TEXT,
        approved_by TEXT,
        approved_at DATETIME,
        rejection_reason TEXT,
        notes TEXT,
        created_at DATETIME NOT NULL,
        updated_at DATETIME,
        FOREIGN KEY (employee_id) REFERENCES employees(id),
        FOREIGN KEY (leave_type_id) REFERENCES leave_types(id),
        FOREIGN KEY (approved_by) REFERENCES users(id)
      )
    ''');

    // Create indexes for leave requests
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_leave_requests_employee ON leave_requests(employee_id)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_leave_requests_status ON leave_requests(status)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_leave_requests_dates ON leave_requests(start_date, end_date)',
    );

    // Leave balances table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS leave_balances (
        id TEXT PRIMARY KEY,
        employee_id TEXT NOT NULL,
        leave_type_id TEXT NOT NULL,
        year INTEGER NOT NULL,
        total_days REAL NOT NULL,
        used_days REAL DEFAULT 0,
        remaining_days REAL NOT NULL,
        carried_forward_days REAL DEFAULT 0,
        last_updated DATETIME,
        created_at DATETIME NOT NULL,
        updated_at DATETIME,
        FOREIGN KEY (employee_id) REFERENCES employees(id),
        FOREIGN KEY (leave_type_id) REFERENCES leave_types(id),
        UNIQUE(employee_id, leave_type_id, year)
      )
    ''');

    // Salary components table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS salary_components (
        id TEXT PRIMARY KEY,
        employee_id TEXT NOT NULL,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        amount REAL NOT NULL,
        is_percentage INTEGER DEFAULT 0,
        is_recurring INTEGER DEFAULT 1,
        is_taxable INTEGER DEFAULT 1,
        effective_from DATE,
        effective_to DATE,
        description TEXT,
        is_active INTEGER DEFAULT 1,
        created_at DATETIME NOT NULL,
        updated_at DATETIME,
        FOREIGN KEY (employee_id) REFERENCES employees(id)
      )
    ''');

    // Payroll table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS payroll (
        id TEXT PRIMARY KEY,
        employee_id TEXT NOT NULL,
        month INTEGER NOT NULL,
        year INTEGER NOT NULL,
        pay_period_start DATE NOT NULL,
        pay_period_end DATE NOT NULL,
        basic_salary REAL NOT NULL,
        allowances REAL DEFAULT 0,
        bonuses REAL DEFAULT 0,
        overtime_pay REAL DEFAULT 0,
        deductions REAL DEFAULT 0,
        penalties REAL DEFAULT 0,
        tax_amount REAL DEFAULT 0,
        insurance_deduction REAL DEFAULT 0,
        loan_deduction REAL DEFAULT 0,
        advance_deduction REAL DEFAULT 0,
        working_days INTEGER NOT NULL,
        present_days INTEGER NOT NULL,
        absent_days INTEGER DEFAULT 0,
        leave_days INTEGER DEFAULT 0,
        paid_leave_days INTEGER DEFAULT 0,
        unpaid_leave_days INTEGER DEFAULT 0,
        overtime_hours REAL DEFAULT 0,
        gross_salary REAL NOT NULL,
        total_deductions REAL NOT NULL,
        net_salary REAL NOT NULL,
        status TEXT NOT NULL DEFAULT 'draft',
        paid_date DATE,
        payment_method TEXT,
        notes TEXT,
        created_at DATETIME NOT NULL,
        updated_at DATETIME,
        FOREIGN KEY (employee_id) REFERENCES employees(id),
        UNIQUE(employee_id, month, year)
      )
    ''');

    // Create indexes for payroll
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_payroll_employee ON payroll(employee_id)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_payroll_period ON payroll(month, year)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_payroll_status ON payroll(status)',
    );

    // Contracts table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS contracts (
        id TEXT PRIMARY KEY,
        employee_id TEXT NOT NULL,
        contract_number TEXT UNIQUE NOT NULL,
        type TEXT NOT NULL,
        start_date DATE NOT NULL,
        end_date DATE,
        is_indefinite INTEGER DEFAULT 0,
        salary REAL NOT NULL,
        currency TEXT DEFAULT 'EGP',
        job_title TEXT NOT NULL,
        department TEXT NOT NULL,
        work_location TEXT,
        working_hours_per_day INTEGER DEFAULT 8,
        working_days_per_week INTEGER DEFAULT 5,
        probation_period_months INTEGER DEFAULT 3,
        notice_period_days INTEGER DEFAULT 30,
        annual_leave_days INTEGER DEFAULT 21,
        terms_and_conditions TEXT,
        status TEXT NOT NULL DEFAULT 'active',
        signed_date DATE,
        auto_renew INTEGER DEFAULT 0,
        renewal_period_months INTEGER,
        notes TEXT,
        created_at DATETIME NOT NULL,
        updated_at DATETIME,
        FOREIGN KEY (employee_id) REFERENCES employees(id)
      )
    ''');

    // Documents table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS documents (
        id TEXT PRIMARY KEY,
        employee_id TEXT NOT NULL,
        title TEXT NOT NULL,
        category TEXT NOT NULL,
        file_name TEXT NOT NULL,
        file_path TEXT NOT NULL,
        file_size INTEGER NOT NULL,
        file_type TEXT NOT NULL,
        mime_type TEXT NOT NULL,
        version INTEGER DEFAULT 1,
        is_verified INTEGER DEFAULT 0,
        verified_by TEXT,
        verified_at DATETIME,
        expiry_date DATE,
        description TEXT,
        tags TEXT,
        is_active INTEGER DEFAULT 1,
        created_at DATETIME NOT NULL,
        updated_at DATETIME,
        FOREIGN KEY (employee_id) REFERENCES employees(id),
        FOREIGN KEY (verified_by) REFERENCES users(id)
      )
    ''');

    // Evaluations table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS evaluations (
        id TEXT PRIMARY KEY,
        employee_id TEXT NOT NULL,
        evaluator_id TEXT NOT NULL,
        evaluation_period_start DATE NOT NULL,
        evaluation_period_end DATE NOT NULL,
        quality_of_work REAL NOT NULL,
        productivity REAL NOT NULL,
        communication REAL NOT NULL,
        teamwork REAL NOT NULL,
        initiative REAL NOT NULL,
        problem_solving REAL NOT NULL,
        attendance_punctuality REAL NOT NULL,
        technical_skills REAL NOT NULL,
        overall_score REAL NOT NULL,
        rating TEXT NOT NULL,
        strengths TEXT,
        areas_for_improvement TEXT,
        goals TEXT,
        comments TEXT,
        status TEXT NOT NULL DEFAULT 'draft',
        submitted_at DATETIME,
        approved_by TEXT,
        approved_at DATETIME,
        created_at DATETIME NOT NULL,
        updated_at DATETIME,
        FOREIGN KEY (employee_id) REFERENCES employees(id),
        FOREIGN KEY (evaluator_id) REFERENCES employees(id),
        FOREIGN KEY (approved_by) REFERENCES users(id)
      )
    ''');
  }

  @override
  Future<List<Map<String, dynamic>>> query(
    String sql, {
    List<dynamic>? arguments,
  }) async {
    try {
      final db = await database;
      return await db.rawQuery(sql, arguments);
    } catch (e) {
      throw DatabaseException(message: 'Query failed: ${e.toString()}');
    }
  }

  @override
  Future<int> insert(
    String table,
    Map<String, dynamic> values, {
    String? conflictAlgorithm,
  }) async {
    try {
      final db = await database;
      return await db.insert(
        table,
        values,
        conflictAlgorithm: conflictAlgorithm != null
            ? ConflictAlgorithm.values.firstWhere(
                (e) => e.toString().split('.').last == conflictAlgorithm,
                orElse: () => ConflictAlgorithm.abort,
              )
            : null,
      );
    } catch (e) {
      throw DatabaseException(message: 'Insert failed: ${e.toString()}');
    }
  }

  @override
  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    try {
      final db = await database;
      return await db.update(table, values, where: where, whereArgs: whereArgs);
    } catch (e) {
      throw DatabaseException(message: 'Update failed: ${e.toString()}');
    }
  }

  @override
  Future<int> delete(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    try {
      final db = await database;
      return await db.delete(table, where: where, whereArgs: whereArgs);
    } catch (e) {
      throw DatabaseException(message: 'Delete failed: ${e.toString()}');
    }
  }

  @override
  Future<void> batch(List<Map<String, dynamic>> operations) async {
    try {
      final db = await database;
      final batch = db.batch();

      for (final operation in operations) {
        final type = operation['type'] as String;
        final table = operation['table'] as String;

        switch (type) {
          case 'insert':
            batch.insert(table, operation['values'] as Map<String, dynamic>);
            break;
          case 'update':
            batch.update(
              table,
              operation['values'] as Map<String, dynamic>,
              where: operation['where'] as String?,
              whereArgs: operation['whereArgs'] as List<dynamic>?,
            );
            break;
          case 'delete':
            batch.delete(
              table,
              where: operation['where'] as String?,
              whereArgs: operation['whereArgs'] as List<dynamic>?,
            );
            break;
        }
      }

      await batch.commit(noResult: true);
    } catch (e) {
      throw DatabaseException(
        message: 'Batch operation failed: ${e.toString()}',
      );
    }
  }

  @override
  Future<T> transaction<T>(Future<T> Function() action) async {
    try {
      final db = await database;
      return await db.transaction((txn) async {
        return await action();
      });
    } catch (e) {
      throw DatabaseException(message: 'Transaction failed: ${e.toString()}');
    }
  }

  @override
  Future<void> execute(String sql, {List<dynamic>? arguments}) async {
    try {
      final db = await database;
      await db.execute(sql, arguments);
    } catch (e) {
      throw DatabaseException(message: 'Execute failed: ${e.toString()}');
    }
  }

  @override
  Future<int> getVersion() async {
    try {
      final db = await database;
      return await db.getVersion();
    } catch (e) {
      throw DatabaseException(message: 'Get version failed: ${e.toString()}');
    }
  }

  @override
  Future<void> setVersion(int version) async {
    try {
      final db = await database;
      await db.setVersion(version);
    } catch (e) {
      throw DatabaseException(message: 'Set version failed: ${e.toString()}');
    }
  }

  @override
  Future<bool> tableExists(String tableName) async {
    try {
      final db = await database;
      final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
        [tableName],
      );
      return result.isNotEmpty;
    } catch (e) {
      throw DatabaseException(
        message: 'Table exists check failed: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<String>> getAllTables() async {
    try {
      final db = await database;
      final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'",
      );
      return result.map((row) => row['name'] as String).toList();
    } catch (e) {
      throw DatabaseException(
        message: 'Get all tables failed: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> dropTable(String tableName) async {
    try {
      final db = await database;
      await db.execute('DROP TABLE IF EXISTS $tableName');
    } catch (e) {
      throw DatabaseException(message: 'Drop table failed: ${e.toString()}');
    }
  }

  @override
  Future<void> createTable(String createTableSql) async {
    try {
      final db = await database;
      await db.execute(createTableSql);
    } catch (e) {
      throw DatabaseException(message: 'Create table failed: ${e.toString()}');
    }
  }

  @override
  Future<void> vacuum() async {
    try {
      final db = await database;
      await db.execute('VACUUM');
    } catch (e) {
      throw DatabaseException(message: 'Vacuum failed: ${e.toString()}');
    }
  }

  @override
  Future<int> getDatabaseSize() async {
    try {
      final Directory documentsDirectory =
          await getApplicationDocumentsDirectory();
      final String path = join(documentsDirectory.path, _config.databaseName);
      final file = File(path);
      if (await file.exists()) {
        return await file.length();
      }
      return 0;
    } catch (e) {
      throw DatabaseException(
        message: 'Get database size failed: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null;
    }
  }
}
