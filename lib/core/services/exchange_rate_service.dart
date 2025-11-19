
import 'package:inovola/core/handlers/api_caller.dart';
import 'package:inovola/core/handlers/api_result.dart';
import 'package:inovola/core/models/exchange_rate_response.dart';

class ExchangeRateService {
  Future<ApiResult<ExchangeRateResponse>> getExchangeRates() async {
    return await ApiCaller.get<ExchangeRateResponse>(
      '/v6/latest/USD',
      responseParser: (json) => ExchangeRateResponse.fromJson(json),
    );
  }
}