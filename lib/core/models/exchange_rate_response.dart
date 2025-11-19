import 'package:json_annotation/json_annotation.dart';

part 'exchange_rate_response.g.dart';
@JsonSerializable()
class ExchangeRateResponse {
  final String result;
  final String provider;
  @JsonKey(name: 'base_code')
  final String baseCode;
  final Map<String, double> rates;

  ExchangeRateResponse({
    required this.result,
    required this.provider,
    required this.baseCode,
    required this.rates,
  });

  factory ExchangeRateResponse.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeRateResponseToJson(this);
}