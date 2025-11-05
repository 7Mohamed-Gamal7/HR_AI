import 'package:equatable/equatable.dart';
import 'database_type.dart';

/// Database configuration class
class DatabaseConfig extends Equatable {
  /// The type of database to use
  final DatabaseType type;

  /// Database name (for SQLite) or database name (for remote databases)
  final String databaseName;

  /// Server host (for remote databases)
  final String? host;

  /// Server port (for remote databases)
  final int? port;

  /// Username (for remote databases)
  final String? username;

  /// Password (for remote databases)
  final String? password;

  /// Use SSL/TLS connection (for remote databases)
  final bool useSSL;

  /// Connection timeout in seconds
  final int connectionTimeout;

  /// Maximum number of connections in pool
  final int maxConnections;

  /// Additional connection parameters
  final Map<String, dynamic>? additionalParams;

  const DatabaseConfig({
    required this.type,
    required this.databaseName,
    this.host,
    this.port,
    this.username,
    this.password,
    this.useSSL = true,
    this.connectionTimeout = 30,
    this.maxConnections = 10,
    this.additionalParams,
  });

  /// Create SQLite configuration
  factory DatabaseConfig.sqlite({
    String databaseName = 'hrms_database.db',
  }) {
    return DatabaseConfig(
      type: DatabaseType.sqlite,
      databaseName: databaseName,
    );
  }

  /// Create SQL Server configuration
  factory DatabaseConfig.sqlServer({
    required String host,
    required String databaseName,
    required String username,
    required String password,
    int port = 1433,
    bool useSSL = true,
    int connectionTimeout = 30,
    int maxConnections = 10,
    Map<String, dynamic>? additionalParams,
  }) {
    return DatabaseConfig(
      type: DatabaseType.sqlServer,
      databaseName: databaseName,
      host: host,
      port: port,
      username: username,
      password: password,
      useSSL: useSSL,
      connectionTimeout: connectionTimeout,
      maxConnections: maxConnections,
      additionalParams: additionalParams,
    );
  }

  /// Create PostgreSQL configuration
  factory DatabaseConfig.postgresql({
    required String host,
    required String databaseName,
    required String username,
    required String password,
    int port = 5432,
    bool useSSL = true,
    int connectionTimeout = 30,
    int maxConnections = 10,
    Map<String, dynamic>? additionalParams,
  }) {
    return DatabaseConfig(
      type: DatabaseType.postgresql,
      databaseName: databaseName,
      host: host,
      port: port,
      username: username,
      password: password,
      useSSL: useSSL,
      connectionTimeout: connectionTimeout,
      maxConnections: maxConnections,
      additionalParams: additionalParams,
    );
  }

  /// Create MySQL configuration
  factory DatabaseConfig.mysql({
    required String host,
    required String databaseName,
    required String username,
    required String password,
    int port = 3306,
    bool useSSL = true,
    int connectionTimeout = 30,
    int maxConnections = 10,
    Map<String, dynamic>? additionalParams,
  }) {
    return DatabaseConfig(
      type: DatabaseType.mysql,
      databaseName: databaseName,
      host: host,
      port: port,
      username: username,
      password: password,
      useSSL: useSSL,
      connectionTimeout: connectionTimeout,
      maxConnections: maxConnections,
      additionalParams: additionalParams,
    );
  }

  /// Get connection string for the database
  String getConnectionString() {
    switch (type) {
      case DatabaseType.sqlite:
        return databaseName;

      case DatabaseType.sqlServer:
        final buffer = StringBuffer();
        buffer.write('Server=$host,$port;');
        buffer.write('Database=$databaseName;');
        buffer.write('User Id=$username;');
        buffer.write('Password=$password;');
        if (useSSL) {
          buffer.write('Encrypt=true;');
          buffer.write('TrustServerCertificate=false;');
        }
        buffer.write('Connection Timeout=$connectionTimeout;');
        if (additionalParams != null) {
          additionalParams!.forEach((key, value) {
            buffer.write('$key=$value;');
          });
        }
        return buffer.toString();

      case DatabaseType.postgresql:
        final buffer = StringBuffer();
        buffer.write('host=$host ');
        buffer.write('port=$port ');
        buffer.write('dbname=$databaseName ');
        buffer.write('user=$username ');
        buffer.write('password=$password ');
        if (useSSL) {
          buffer.write('sslmode=require ');
        }
        buffer.write('connect_timeout=$connectionTimeout');
        return buffer.toString();

      case DatabaseType.mysql:
        return 'mysql://$username:$password@$host:$port/$databaseName';
    }
  }

  /// Copy with method
  DatabaseConfig copyWith({
    DatabaseType? type,
    String? databaseName,
    String? host,
    int? port,
    String? username,
    String? password,
    bool? useSSL,
    int? connectionTimeout,
    int? maxConnections,
    Map<String, dynamic>? additionalParams,
  }) {
    return DatabaseConfig(
      type: type ?? this.type,
      databaseName: databaseName ?? this.databaseName,
      host: host ?? this.host,
      port: port ?? this.port,
      username: username ?? this.username,
      password: password ?? this.password,
      useSSL: useSSL ?? this.useSSL,
      connectionTimeout: connectionTimeout ?? this.connectionTimeout,
      maxConnections: maxConnections ?? this.maxConnections,
      additionalParams: additionalParams ?? this.additionalParams,
    );
  }

  @override
  List<Object?> get props => [
        type,
        databaseName,
        host,
        port,
        username,
        password,
        useSSL,
        connectionTimeout,
        maxConnections,
        additionalParams,
      ];

  @override
  String toString() {
    return 'DatabaseConfig(type: ${type.displayName}, database: $databaseName, host: $host)';
  }
}

