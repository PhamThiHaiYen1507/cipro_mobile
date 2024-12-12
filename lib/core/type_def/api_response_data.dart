import 'package:either_dart/either.dart';

import '../exceptions/api_exception.dart';

typedef ApiResponseData<T> = Either<ApiException, T>;
