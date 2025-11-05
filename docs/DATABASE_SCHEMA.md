# Database Schema Documentation

## Overview
This document describes the database schema for the HR Management System. The system uses SQLite for local storage with support for remote databases (SQL Server, PostgreSQL, MySQL) via API.

## Entity Relationship Diagram

```
┌─────────────┐       ┌──────────────┐       ┌─────────────┐
│ Departments │◄──────┤  Employees   ├──────►│  Positions  │
└─────────────┘       └──────┬───────┘       └─────────────┘
                             │
                    ┌────────┼────────┐
                    │        │        │
              ┌─────▼──┐ ┌───▼────┐ ┌▼────────┐
              │Attendance│ │ Leaves │ │ Payroll │
              └──────────┘ └────────┘ └─────────┘
```

## Tables

### 1. Users
Authentication and user management.

```sql
CREATE TABLE users (
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
);
```

### 2. Employees
Core employee information.

```sql
CREATE TABLE employees (
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
);
```

### 3. Departments
Organizational departments.

```sql
CREATE TABLE departments (
    id TEXT PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    description TEXT,
    manager_id TEXT,
    is_active INTEGER DEFAULT 1,
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    FOREIGN KEY (manager_id) REFERENCES employees(id)
);
```

### 4. Positions
Job positions and titles.

```sql
CREATE TABLE positions (
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
);
```

### 5. Attendance
Daily attendance records.

```sql
CREATE TABLE attendance (
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
);
```

### 6. Attendance Rules
Configurable attendance rules.

```sql
CREATE TABLE attendance_rules (
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
);
```

### 7. Holidays
Official holidays and rest days.

```sql
CREATE TABLE holidays (
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
);
```

### 8. Leave Types
Types of leaves available.

```sql
CREATE TABLE leave_types (
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
);
```

### 9. Leave Requests
Employee leave applications.

```sql
CREATE TABLE leave_requests (
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
);
```

### 10. Leave Balances
Employee leave balances.

```sql
CREATE TABLE leave_balances (
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
);
```

### 11. Payroll
Monthly payroll records.

```sql
CREATE TABLE payroll (
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
);
```

### 12. Salary Components
Allowances, deductions, bonuses, penalties.

```sql
CREATE TABLE salary_components (
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
);
```

## Indexes

```sql
-- Employee indexes
CREATE INDEX idx_employees_department ON employees(department_id);
CREATE INDEX idx_employees_position ON employees(position_id);
CREATE INDEX idx_employees_status ON employees(status);
CREATE INDEX idx_employees_manager ON employees(manager_id);

-- Attendance indexes
CREATE INDEX idx_attendance_employee ON attendance(employee_id);
CREATE INDEX idx_attendance_date ON attendance(date);
CREATE INDEX idx_attendance_status ON attendance(status);

-- Leave request indexes
CREATE INDEX idx_leave_requests_employee ON leave_requests(employee_id);
CREATE INDEX idx_leave_requests_status ON leave_requests(status);
CREATE INDEX idx_leave_requests_dates ON leave_requests(start_date, end_date);

-- Payroll indexes
CREATE INDEX idx_payroll_employee ON payroll(employee_id);
CREATE INDEX idx_payroll_period ON payroll(month, year);
CREATE INDEX idx_payroll_status ON payroll(status);
```

## Data Types

- **TEXT** - String values
- **INTEGER** - Integer values (also used for boolean: 0 = false, 1 = true)
- **REAL** - Floating-point numbers
- **DATE** - Date values (stored as TEXT in ISO 8601 format: YYYY-MM-DD)
- **DATETIME** - Date and time values (stored as TEXT in ISO 8601 format: YYYY-MM-DD HH:MM:SS)
- **TIME** - Time values (stored as TEXT in format: HH:MM:SS)

## Constraints

- **PRIMARY KEY** - Unique identifier for each record
- **FOREIGN KEY** - Maintains referential integrity
- **UNIQUE** - Ensures uniqueness of values
- **NOT NULL** - Field cannot be null
- **DEFAULT** - Default value if not specified

## Notes

1. All IDs use UUID format for better distribution and uniqueness
2. Timestamps are stored in UTC and converted to local time in the application
3. Soft delete is implemented using status fields rather than actual deletion
4. All monetary values are stored as REAL (floating-point) with 2 decimal precision
5. Duration values are stored in minutes as INTEGER

