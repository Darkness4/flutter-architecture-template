class CacheException implements Exception {
  final dynamic message;

  CacheException([this.message]);

  @override
  String toString() {
    if (message == null) return "CacheException";
    return "CacheException: $message";
  }
}

class ServerException implements Exception {
  final dynamic message;

  ServerException([this.message]);

  @override
  String toString() {
    if (message == null) return "ServerException";
    return "ServerException: $message";
  }
}
