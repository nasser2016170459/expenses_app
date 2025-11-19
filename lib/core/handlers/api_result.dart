
import 'package:inovola/core/handlers/api_exceptions.dart';

class ApiResult<T> {
  final bool isSucceeded;
  final T? resultData;
  final String? errorTitle;
  final String? errorMessage;
  final ApiException? apiException;

  bool get isFailed => !isSucceeded;

  ApiResult.succeeded([this.resultData])
      : isSucceeded = true,
        errorTitle = null,
        errorMessage = null,
        apiException = null;

  ApiResult.failed([this.errorTitle, this.errorMessage, this.apiException])
      : isSucceeded = false,
        resultData = null;
}
