import 'package:inovola/core/handlers/api_exceptions.dart';
import 'package:inovola/core/handlers/api_result.dart';

abstract mixin class ApiCallsHandler {
  Future<ApiResult<T>> handleApiCall<T>(
    Future<ApiResult<T>> Function() apiCall, {
    Future<ApiResult<T>> Function(ApiException)? onForbidden,
    Future<ApiResult<T>> Function(ApiException)? onBadRequest,
    Future<ApiResult<T>> Function(ApiException)? onNotFound,
    Future<ApiResult<T>> Function(ApiException)? onTimeout,
    Future<ApiResult<T>> Function(ApiException)? onUnauthorized,
    Future<ApiResult<T>> Function(ApiException)? onConflict,
    Future<ApiResult<T>> Function(ApiException)? onUnknown,
    Future<ApiResult<T>> Function(ApiException)? onLargePayload,
    Future<ApiResult<T>> Function(ApiException)? onGone,
  }) async {
    try {
      return await apiCall();
    } on TimeoutException catch (e, stack) {
      if (onTimeout != null) return onTimeout.call(e);
      return ApiResult.failed(e.runtimeType.toString(), "Request Timed Out", e);
    } on BadRequestException catch (e, stack) {
      if (onBadRequest != null) return onBadRequest.call(e);
      return ApiResult.failed(e.runtimeType.toString(), "Bad Request", e);
    } on NotFoundException catch (e, stack) {
      if (onNotFound != null) return onNotFound.call(e);
      return ApiResult.failed(e.runtimeType.toString(), "Resource Not Found", e);
    } on ConflictException catch (e, stack) {
      if (onConflict != null) return onConflict.call(e);
      return ApiResult.failed(e.runtimeType.toString(), "Resource Already Exists", e);
    } on UnauthorizedException catch (e, stack) {
      if (onUnauthorized != null) return onUnauthorized.call(e);
      return ApiResult.failed(e.runtimeType.toString(), "Unauthorized Access", e);
    } on ForbiddenException catch (e, stack) {
      if (onForbidden != null) return onForbidden.call(e);
      return ApiResult.failed(e.runtimeType.toString(), "Forbidden Access", e);
    } on PayloadTooLargeException catch (e, stack) {
      if (onLargePayload != null) return onLargePayload.call(e);
      return ApiResult.failed(
        e.runtimeType.toString(),
        "Maximum total size of files exceeded. Please reduce to less than 100MB.",
        e,
      );
    } on UnknownException catch (e, stack) {
      if (onUnknown != null) return onUnknown.call(e);
      return ApiResult.failed(e.runtimeType.toString(), "Unknown Exception", e);
    } on GoneException catch (e, stack) {
      if (onGone != null) return onGone.call(e);
      return ApiResult.failed(e.runtimeType.toString(), "Resource is no longer available", e);
    } catch (e, stack) {
      return ApiResult.failed(e.runtimeType.toString(), "Error occurred, please try again!");
    }
  }
}
