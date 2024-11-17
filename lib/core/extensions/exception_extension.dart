import '../exceptions/api_exception.dart';
import '../exceptions/exception_handler.dart';

extension ExceptionExtension on Exception {
  ApiException handlerApiException([StackTrace? stackTrace]) =>
      ExceptionHandler.handler(this, stackTrace);
}
