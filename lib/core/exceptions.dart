class ServerException implements Exception {
  final String message;

  const ServerException({this.message = "Server error occurred."});
}
