class ServerException implements Exception {}

class AuthException implements Exception {}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}
