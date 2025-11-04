import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;
  
  DatabaseService._init();
  
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('hr_management.db');
    return _database!;
  }
  
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: _onConfigure,
    );
  }
  
  Future<void> _onConfigure(Database db) async {
    // تمكين المفاتيح الأجنبية
    await db.execute('PRAGMA foreign_keys = ON');
  }
  
  Future<void> _createDB(Database db, int version) async {
    // جدول المستخدمين والصلاحيات
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        email TEXT UNIQUE,
        role TEXT NOT NULL,
        is_active INTEGER DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
    
    // جدول الموظفين
    await db.execute('''
      CREATE TABLE employees (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        employee_number TEXT UNIQUE NOT NULL,
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        full_name TEXT NOT NULL,
        email TEXT UNIQUE,
        phone TEXT,
        mobile TEXT,
        date_of_birth TEXT,
        nationality TEXT,
        gender TEXT,
        marital_status TEXT,
        address TEXT,
        city TEXT,
        country TEXT,
        postal_code TEXT,
        department_id INTEGER,
        job_title_id INTEGER,
        manager_id INTEGER,
        hire_date TEXT,
        salary REAL,
        employment_type TEXT,
        status TEXT DEFAULT 'active',
        profile_image TEXT,
        notes TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (department_id) REFERENCES departments (id),
        FOREIGN KEY (job_title_id) REFERENCES job_titles (id),
        FOREIGN KEY (manager_id) REFERENCES employees (id)
      )
    ''');
    
    // جدول الأقسام
    await db.execute('''
      CREATE TABLE departments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT UNIQUE NOT NULL,
        name TEXT NOT NULL,
        description TEXT,
        manager_id INTEGER,
        parent_department_id INTEGER,
        is_active INTEGER DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (manager_id) REFERENCES employees (id),
        FOREIGN KEY (parent_department_id) REFERENCES departments (id)
      )
    ''');
    
    // جدول المسميات الوظيفية
    await db.execute('''
      CREATE TABLE job_titles (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT UNIQUE NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        department_id INTEGER,
        level INTEGER,
        is_active INTEGER DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (department_id) REFERENCES departments (id)
      )
    ''');
    
    // جدول الحضور والانصراف
    await db.execute('''
      CREATE TABLE attendance (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        employee_id INTEGER NOT NULL,
        date TEXT NOT NULL,
        check_in_time TEXT,
        check_out_time TEXT,
        work_hours REAL,
        overtime_hours REAL,
        late_minutes INTEGER DEFAULT 0,
        early_minutes INTEGER DEFAULT 0,
        status TEXT DEFAULT 'present',
        notes TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (employee_id) REFERENCES employees (id)
      )
    ''');
    
    // جدول الإجازات
    await _createLeaveTables(db);

    // جدول المرتبات
    await _createPayrollTables(db);
    
    // جدول المرتبات
    await db.execute('''
      CREATE TABLE payroll_periods (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        start_date TEXT NOT NULL,
        end_date TEXT NOT NULL,
        status TEXT DEFAULT 'open',
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
    
    await db.execute('''
      CREATE TABLE salary_components (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT UNIQUE NOT NULL,
        name TEXT NOT NULL,
        type TEXT NOT NULL, -- basic, allowance, deduction, bonus
        calculation_type TEXT NOT NULL, -- fixed, percentage
        amount REAL,
        percentage REAL,
        is_taxable INTEGER DEFAULT 0,
        is_active INTEGER DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
    
    await db.execute('''
      CREATE TABLE employee_salaries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        employee_id INTEGER NOT NULL,
        payroll_period_id INTEGER NOT NULL,
        basic_salary REAL NOT NULL,
        total_allowances REAL DEFAULT 0,
        total_deductions REAL DEFAULT 0,
        net_salary REAL NOT NULL,
        payment_status TEXT DEFAULT 'pending',
        payment_date TEXT,
        notes TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (employee_id) REFERENCES employees (id),
        FOREIGN KEY (payroll_period_id) REFERENCES payroll_periods (id)
      )
    ''');
    
    // جدول التقييمات
    await db.execute('''
      CREATE TABLE evaluation_periods (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        start_date TEXT NOT NULL,
        end_date TEXT NOT NULL,
        status TEXT DEFAULT 'open',
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
    
    await db.execute('''
      CREATE TABLE evaluation_forms (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        total_score REAL DEFAULT 100,
        is_active INTEGER DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
    
    await db.execute('''
      CREATE TABLE evaluations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        employee_id INTEGER NOT NULL,
        evaluator_id INTEGER NOT NULL,
        evaluation_period_id INTEGER NOT NULL,
        evaluation_form_id INTEGER NOT NULL,
        total_score REAL,
        rating TEXT,
        comments TEXT,
        status TEXT DEFAULT 'draft',
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (employee_id) REFERENCES employees (id),
        FOREIGN KEY (evaluator_id) REFERENCES employees (id),
        FOREIGN KEY (evaluation_period_id) REFERENCES evaluation_periods (id),
        FOREIGN KEY (evaluation_form_id) REFERENCES evaluation_forms (id)
      )
    ''');
    
    await db.execute('''
      CREATE TABLE attendance_rules (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        check_in_time TEXT NOT NULL,
        check_out_time TEXT NOT NULL,
        break_duration INTEGER,
        late_threshold INTEGER DEFAULT 15,
        early_leave_threshold INTEGER DEFAULT 15,
        is_flexible INTEGER DEFAULT 0,
        allow_overtime INTEGER DEFAULT 1,
        working_days TEXT DEFAULT '1,2,3,4,5',
        effective_from TEXT,
        effective_to TEXT,
        is_active INTEGER DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
    
    await db.execute('''
      CREATE TABLE attendance_records (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        employee_id INTEGER NOT NULL,
        date TEXT NOT NULL,
        check_in_time TEXT,
        check_out_time TEXT,
        break_start_time TEXT,
        break_end_time TEXT,
        overtime_start_time TEXT,
        overtime_end_time TEXT,
        total_hours INTEGER,
        overtime_hours INTEGER,
        break_duration INTEGER,
        is_late INTEGER DEFAULT 0,
        is_early_leave INTEGER DEFAULT 0,
        status TEXT DEFAULT 'present',
        notes TEXT,
        device_id TEXT,
        location TEXT,
        latitude REAL,
        longitude REAL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (employee_id) REFERENCES employees (id)
      )
    ''');
    
    // جدول العقود
    await db.execute('''
      CREATE TABLE contracts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        employee_id INTEGER NOT NULL,
        contract_number TEXT UNIQUE NOT NULL,
        contract_type TEXT NOT NULL,
        start_date TEXT NOT NULL,
        end_date TEXT,
        probation_period_days INTEGER DEFAULT 90,
        salary REAL NOT NULL,
        benefits TEXT,
        terms_conditions TEXT,
        status TEXT DEFAULT 'active',
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (employee_id) REFERENCES employees (id)
      )
    ''');
    
    // جدول المستندات
    await db.execute('''
      CREATE TABLE document_categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        is_active INTEGER DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
    
    await db.execute('''
      CREATE TABLE documents (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        employee_id INTEGER NOT NULL,
        category_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        file_name TEXT NOT NULL,
        file_path TEXT NOT NULL,
        file_size INTEGER,
        file_type TEXT,
        description TEXT,
        expiry_date TEXT,
        is_confidential INTEGER DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (employee_id) REFERENCES employees (id),
        FOREIGN KEY (category_id) REFERENCES document_categories (id)
      )
    ''');
    
    // جدول الإعدادات
    await db.execute('''
      CREATE TABLE settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        key TEXT UNIQUE NOT NULL,
        value TEXT,
        type TEXT DEFAULT 'string',
        description TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
    
    // إدخال البيانات الافتراضية
    await _insertDefaultData(db);
    
    // إدخال قواعد الحضور الافتراضية
    await _insertDefaultAttendanceRules(db);

    // إدخال أنواع الإجازات الافتراضية
    await _insertDefaultLeaveTypes(db);
  }

  Future<void> _createLeaveTables(Database db) async {
    await db.execute('''
      CREATE TABLE leave_types (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        code TEXT UNIQUE NOT NULL,
        description TEXT,
        max_days_per_year REAL,
        is_paid INTEGER DEFAULT 1,
        is_deducted INTEGER DEFAULT 0,
        requires_attachment INTEGER DEFAULT 0,
        status TEXT DEFAULT 'active',
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE leave_requests (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        employee_id INTEGER NOT NULL,
        leave_type_id INTEGER NOT NULL,
        start_date TEXT NOT NULL,
        end_date TEXT NOT NULL,
        total_days REAL NOT NULL,
        reason TEXT,
        status TEXT DEFAULT 'pending',
        approved_by_id INTEGER,
        approver_comments TEXT,
        attachment_path TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (employee_id) REFERENCES employees (id) ON DELETE CASCADE,
        FOREIGN KEY (leave_type_id) REFERENCES leave_types (id) ON DELETE RESTRICT,
        FOREIGN KEY (approved_by_id) REFERENCES users (id) ON DELETE SET NULL
      )
    ''');
  }
  
  Future<void> _insertDefaultLeaveTypes(Database db) async {
    final now = DateTime.now().toIso8601String();
    final leaveTypes = [
      {
        'name': 'إجازة سنوية',
        'code': 'ANNUAL',
        'max_days_per_year': 21,
        'is_paid': 1,
        'status': 'active',
      },
      {
        'name': 'إجازة مرضية',
        'code': 'SICK',
        'max_days_per_year': 15,
        'is_paid': 1,
        'requires_attachment': 1,
        'status': 'active',
      },
      {
        'name': 'إجازة عارضة',
        'code': 'CASUAL',
        'max_days_per_year': 6,
        'is_paid': 1,
        'status': 'active',
      },
      {
        'name': 'إجازة غير مدفوعة',
        'code': 'UNPAID',
        'is_paid': 0,
        'status': 'active',
      },
      {
        'name': 'إجازة أمومة',
        'code': 'MATERNITY',
        'max_days_per_year': 90,
        'is_paid': 1,
        'requires_attachment': 1,
        'status': 'active',
      },
    ];

    for (final type in leaveTypes) {
      await db.insert('leave_types', {
        ...type,
        'created_at': now,
        'updated_at': now,
      });
    }
  }

  Future<void> _createPayrollTables(Database db) async {
    await db.execute('''
      CREATE TABLE payroll_periods (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        start_date TEXT NOT NULL,
        end_date TEXT NOT NULL,
        status TEXT DEFAULT 'open',
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE salary_components (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT UNIQUE NOT NULL,
        name TEXT NOT NULL,
        type TEXT NOT NULL, -- basic, allowance, deduction, bonus
        calculation_type TEXT NOT NULL, -- fixed, percentage
        amount REAL,
        percentage REAL,
        is_taxable INTEGER DEFAULT 0,
        is_active INTEGER DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE employee_salaries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        employee_id INTEGER NOT NULL,
        payroll_period_id INTEGER NOT NULL,
        basic_salary REAL NOT NULL,
        total_allowances REAL DEFAULT 0,
        total_deductions REAL DEFAULT 0,
        net_salary REAL NOT NULL,
        payment_status TEXT DEFAULT 'pending',
        payment_date TEXT,
        notes TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (employee_id) REFERENCES employees (id) ON DELETE CASCADE,
        FOREIGN KEY (payroll_period_id) REFERENCES payroll_periods (id) ON DELETE RESTRICT
      )
    ''');
  }
  
  Future<void> _insertDefaultAttendanceRules(Database db) async {
    final rules = [
      {
        'name': 'الدوام الصباحي',
        'check_in_time': '08:00',
        'check_out_time': '17:00',
        'break_duration': 60,
        'late_threshold': 15,
        'early_leave_threshold': 15,
        'is_flexible': 0,
        'allow_overtime': 1,
        'working_days': '1,2,3,4,5',
        'effective_from': '2024-01-01',
        'effective_to': '2024-12-31',
        'is_active': 1,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      },
      {
        'name': 'الدوام المسائي',
        'check_in_time': '14:00',
        'check_out_time': '23:00',
        'break_duration': 60,
        'late_threshold': 15,
        'early_leave_threshold': 15,
        'is_flexible': 0,
        'allow_overtime': 1,
        'working_days': '1,2,3,4,5',
        'effective_from': '2024-01-01',
        'effective_to': '2024-12-31',
        'is_active': 1,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      },
      {
        'name': 'الدوام المرن',
        'check_in_time': '07:00',
        'check_out_time': '18:00',
        'break_duration': 60,
        'late_threshold': 30,
        'early_leave_threshold': 30,
        'is_flexible': 1,
        'allow_overtime': 1,
        'working_days': '1,2,3,4,5',
        'effective_from': '2024-01-01',
        'effective_to': '2024-12-31',
        'is_active': 1,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      }
    ];

    for (final rule in rules) {
      await db.insert('attendance_rules', rule);
    }
  }

  Future<void> _insertDefaultData(Database db) async {
    final now = DateTime.now().toIso8601String();
    
    // مستخدم افتراضي
    await db.insert('users', {
      'username': 'admin',
      'password': '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', // admin123
      'email': 'admin@company.com',
      'role': 'admin',
      'created_at': now,
      'updated_at': now,
    });
    
    // أنواع الإجازات الافتراضية
    final leaveTypes = [
      {'code': 'ANNUAL', 'name': 'إجازة سنوية', 'max_days_per_year': 30},
      {'code': 'SICK', 'name': 'إجازة مرضية', 'max_days_per_year': 15},
      {'code': 'EMERGENCY', 'name': 'إجازة طارئة', 'max_days_per_year': 5},
      {'code': 'MATERNITY', 'name': 'إجازة أمومة', 'max_days_per_year': 90},
      {'code': 'PATERNITY', 'name': 'إجازة أبوة', 'max_days_per_year': 3},
    ];
    
    for (final leaveType in leaveTypes) {
      await db.insert('leave_types', {
        'code': leaveType['code'],
        'name': leaveType['name'],
        'max_days_per_year': leaveType['max_days_per_year'],
        'created_at': now,
        'updated_at': now,
      });
    }
    
    // إعدادات النظام الافتراضية
    final settings = [
      {'key': 'company_name', 'value': 'شركتي'},
      {'key': 'company_address', 'value': 'العنوان'},
      {'key': 'company_phone', 'value': '0123456789'},
      {'key': 'company_email', 'value': 'info@company.com'},
      {'key': 'working_hours_per_day', 'value': '8'},
      {'key': 'working_days_per_week', 'value': '5'},
      {'key': 'max_late_minutes', 'value': '15'},
      {'key': 'overtime_rate', 'value': '1.5'},
    ];
    
    for (final setting in settings) {
      await db.insert('settings', {
        'key': setting['key'],
        'value': setting['value'],
        'created_at': now,
        'updated_at': now,
      });
    }
  }
  
  // إغلاق قاعدة البيانات
  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
  
  // تهيئة قاعدة البيانات
  Future<void> initialize() async {
    await database;
  }
  
  // حذف قاعدة البيانات
  Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'hr_management.db');
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }
  
  // العمليات الأساسية
  
  // الإدخال
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await instance.database;
    return await db.insert(table, data);
  }
  
  // الاستعلام
  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final db = await instance.database;
    return await db.query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }
  
  // التحديث
  Future<int> update(
    String table,
    Map<String, dynamic> data, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await instance.database;
    return await db.update(
      table,
      data,
      where: where,
      whereArgs: whereArgs,
    );
  }
  
  // الحذف
  Future<int> delete(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await instance.database;
    return await db.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }
  
  // الاستعلام المخصص
  Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<dynamic>? arguments]) async {
    final db = await instance.database;
    return await db.rawQuery(sql, arguments);
  }
  
  // الأمر المخصص
  Future<int> rawInsert(String sql, [List<dynamic>? arguments]) async {
    final db = await instance.database;
    return await db.rawInsert(sql, arguments);
  }
  
  // التحديث المخصص
  Future<int> rawUpdate(String sql, [List<dynamic>? arguments]) async {
    final db = await instance.database;
    return await db.rawUpdate(sql, arguments);
  }
  
  // الحذف المخصص
  Future<int> rawDelete(String sql, [List<dynamic>? arguments]) async {
    final db = await instance.database;
    return await db.rawDelete(sql, arguments);
  }
  
  // معاملة
  Future<T> transaction<T>(Future<T> Function(Transaction txn) action) async {
    final db = await instance.database;
    return await db.transaction(action);
  }
  
  // دفعة من العمليات
  Future<void> batch(List<Function(Database, Batch)> operations) async {
    final db = await instance.database;
    final batch = db.batch();
    
    for (final operation in operations) {
      operation(db, batch);
    }
    
    await batch.commit();
  }
}