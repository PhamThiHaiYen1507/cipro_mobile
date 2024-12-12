class ApiException<T> implements Exception {
  final String? message;

  ApiException({this.message});
}
