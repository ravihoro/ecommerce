class ServerException implements Exception {
  final String message;

  const ServerException({
    this.message = "Server error occurred.",
  });
}

class DatabaseInsertException implements Exception {
  final String message;

  const DatabaseInsertException({
    this.message = "Failed to insert favorite into database.",
  });
}

class DatabaseDeleteException implements Exception {
  final String message;

  const DatabaseDeleteException({
    this.message = "Failed to delete favorite from database.",
  });
}

class DatabaseFetchException implements Exception {
  final String message;

  const DatabaseFetchException({
    this.message = "Failed to fetch favorites from database.",
  });
}
