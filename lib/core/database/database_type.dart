/// Database type enumeration
enum DatabaseType {
  /// SQLite - Local database for offline-first capability
  sqlite,

  /// SQL Server - Primary production database
  sqlServer,

  /// PostgreSQL - Alternative production database
  postgresql,

  /// MySQL - Alternative production database
  mysql,
}

/// Extension methods for DatabaseType
extension DatabaseTypeExtension on DatabaseType {
  /// Get the display name of the database type
  String get displayName {
    switch (this) {
      case DatabaseType.sqlite:
        return 'SQLite';
      case DatabaseType.sqlServer:
        return 'SQL Server';
      case DatabaseType.postgresql:
        return 'PostgreSQL';
      case DatabaseType.mysql:
        return 'MySQL';
    }
  }

  /// Check if this is a remote database
  bool get isRemote {
    return this != DatabaseType.sqlite;
  }

  /// Check if this is a local database
  bool get isLocal {
    return this == DatabaseType.sqlite;
  }
}

