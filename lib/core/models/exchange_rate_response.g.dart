// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_rate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeRateResponse _$ExchangeRateResponseFromJson(
        Map<String, dynamic> json) =>
    ExchangeRateResponse(
      result: json['result'] as String,
      provider: json['provider'] as String,
      baseCode: json['base_code'] as String,
      rates: (json['rates'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$ExchangeRateResponseToJson(
        ExchangeRateResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'provider': instance.provider,
      'base_code': instance.baseCode,
      'rates': instance.rates,
    };
