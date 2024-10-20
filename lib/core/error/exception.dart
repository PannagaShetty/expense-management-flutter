class ServerException implements Exception {
  final String message;
  final String? statusCode;
  final String? errorCode;

  ServerException(this.message, {this.statusCode, this.errorCode});
}
