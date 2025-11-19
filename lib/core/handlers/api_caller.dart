import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:http_parser/http_parser.dart';
import 'package:inovola/core/api_environment.dart';
import 'package:inovola/core/app_logger.dart';
import 'package:inovola/core/handlers/api_exceptions.dart';
import 'package:inovola/core/handlers/api_result.dart';

enum RequestType { GET, POST, PUT, DELETE, PATCH }

class ApiCaller {
  static const timeoutDuration = Duration(seconds: 60);
  static final _logger = AppLogger("ApiCaller");
  static final _apiInterceptor = InterceptedClient.build(
    requestTimeout: timeoutDuration,
    interceptors: [ApiInterceptor()],
  );

  static Future<ApiResult<T>> get<T>(
    String url, {
    Map<String, dynamic>? params,
    String? token,
    T Function(dynamic)? responseParser,
  }) async =>
      await _callApi<T>(
        _buildRequest(url, RequestType.GET, params: params, token: token),
        responseParser,
      );

  static Future<ApiResult<T>> post<T>(
    String url, {
    Map<String, dynamic>? params,
    String? token,
    T Function(dynamic)? responseParser,
    dynamic data,
  }) async =>
      await _callApi<T>(
        _buildRequest(url, RequestType.POST, body: data, params: params, token: token),
        responseParser,
      );

  static Future<ApiResult<T>> put<T>(
    String url, {
    Map<String, dynamic>? params,
    String? token,
    T Function(dynamic)? responseParser,
    dynamic data,
  }) async =>
      await _callApi<T>(
        _buildRequest(url, RequestType.PUT, body: data, params: params, token: token),
        responseParser,
      );

  static Future<ApiResult<T>> delete<T>(
    String url, {
    Map<String, dynamic>? params,
    String? token,
    T Function(dynamic)? responseParser,
    dynamic data,
  }) async =>
      await _callApi<T>(
        _buildRequest(url, RequestType.DELETE, body: data, params: params, token: token),
        responseParser,
      );

  static Future<ApiResult<T>> patch<T>(
    String url, {
    Map<String, dynamic>? params,
    String? token,
    T Function(dynamic)? responseParser,
    dynamic data,
  }) async =>
      await _callApi<T>(
        _buildRequest(url, RequestType.PATCH, body: data, params: params, token: token),
        responseParser,
      );


  static Future<ApiResult<T>> _callApi<T>(Future<Response> request, T Function(dynamic)? responseParser) async {
    try {
      final response = await request;
      if (response.statusCode == 200) {
        final parsedResponse = responseParser?.call(jsonDecode(utf8.decode(response.bodyBytes)));
        return ApiResult.succeeded(parsedResponse);
      }
      if (response.statusCode == 400) throw BadRequestException();
      if (response.statusCode == 401) throw UnauthorizedException();
      if (response.statusCode == 403) throw ForbiddenException();
      if (response.statusCode == 404) throw NotFoundException();
      if (response.statusCode == 409) throw ConflictException();
      if (response.statusCode == 410) throw GoneException();
      throw UnknownException();
    } catch (e) {
      _logger.error(e.runtimeType.toString());
      if (e is SocketException || e is ClientException || e is TimeoutException) throw TimeoutException();
      if (e is TypeError) throw ServerErrorException();
      rethrow;
    }
  }

  static Map<String, String> _buildHeaders(String? token) => {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      };

  static Future<Response> _buildRequest(
    String url,
    RequestType requestType, {
    Map<String, dynamic>? params,
    String? token,
    dynamic body,
  }) {
    switch (requestType) {
      case RequestType.GET:
        return _apiInterceptor.get(
          Uri.parse(ApiEnvironment.apiUrl + url),
          params: params,
          headers: _buildHeaders(token),
        );
      case RequestType.POST:
        return _apiInterceptor.post(
          Uri.parse(ApiEnvironment.apiUrl + url),
          params: params,
          headers: _buildHeaders(token),
          body: jsonEncode(body),
        );
      case RequestType.DELETE:
        return _apiInterceptor.delete(
          Uri.parse(ApiEnvironment.apiUrl + url),
          params: params,
          headers: _buildHeaders(token),
          body: jsonEncode(body),
        );
      case RequestType.PUT:
        return _apiInterceptor.put(
          Uri.parse(ApiEnvironment.apiUrl + url),
          params: params,
          headers: _buildHeaders(token),
          body: jsonEncode(body),
        );
      case RequestType.PATCH:
        return _apiInterceptor.patch(
          Uri.parse(ApiEnvironment.apiUrl + url),
          params: params,
          headers: _buildHeaders(token),
          body: jsonEncode(body),
        );
    }
  }
}

class ApiInterceptor extends InterceptorContract {
  final _logger = AppLogger("ApiInterceptor");

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) async {
    final requestCode = request.url.hashCode;
    _logger.info("[$requestCode] ${request.method} => ${request.url}");
    _logger.info("[$requestCode] HEADERS: ${request.headers}");
    if (request is MultipartRequest) {
      _logger.info("[$requestCode] FIELDS: ${request.fields}");
      _logger.info("[$requestCode] FILES COUNT: ${request.files.length}");
    } else if (request is Request) {
      _logger.info("[$requestCode] BODY: ${request.body}");
    }
    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) async {
    final requestCode = response.request!.url.hashCode;
    final responseBody = response is Response ? response.body : null;
    if (response.statusCode == 200) {
      _logger.success("[$requestCode] OUTPUT: ${response.statusCode} ${responseBody ?? ""}");
    } else {
      _logger.error("[$requestCode] OUTPUT: ${response.statusCode} ${responseBody ?? ""}");
    }
    return response;
  }
}
