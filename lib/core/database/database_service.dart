import 'database_config.dart';

/// Abstract database service interface
/// Provides a unified interface for different database types
abstract class DatabaseService {
  /// Get the database configuration
  DatabaseConfig get config;

  /// Initialize the database connection
  Future<void> initialize();

  /// Close the database connection
  Future<void> close();

  /// Check if the database is initialized
  bool get isInitialized;

  /// Execute a raw query and return results
  Future<List<Map<String, dynamic>>> query(
    String sql, {
    List<dynamic>? arguments,
  });

  /// Execute a raw insert query and return the inserted ID
  Future<int> insert(
    String table,
    Map<String, dynamic> values, {
    String? conflictAlgorithm,
  });

  /// Execute a raw update query and return the number of affected rows
  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String? where,
    List<dynamic>? whereArgs,
  });

  /// Execute a raw delete query and return the number of affected rows
  Future<int> delete(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  });

  /// Execute a batch of operations in a transaction
  Future<void> batch(List<Map<String, dynamic>> operations);

  /// Execute operations in a transaction
  Future<T> transaction<T>(Future<T> Function() action);

  /// Execute a raw SQL statement (for DDL operations)
  Future<void> execute(String sql, {List<dynamic>? arguments});

  /// Get the database version
  Future<int> getVersion();

  /// Set the database version
  Future<void> setVersion(int version);

  /// Check if a table exists
  Future<bool> tableExists(String tableName);

  /// Get all table names
  Future<List<String>> getAllTables();

  /// Drop a table
  Future<void> dropTable(String tableName);

  /// Create a table
  Future<void> createTable(String createTableSql);

  /// Vacuum the database (optimize storage)
  Future<void> vacuum();

  /// Get database size in bytes
  Future<int> getDatabaseSize();
}

