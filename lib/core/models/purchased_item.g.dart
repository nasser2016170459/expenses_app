// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchased_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchasedItem _$PurchasedItemFromJson(Map<String, dynamic> json) =>
    PurchasedItem(
      id: json['id'] as String,
      price: (json['price'] as num).toDouble(),
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      category: $enumDecodeNullable(
          _$PurchasedItemCategoryEnumMap, json['category'],
          unknownValue: JsonKey.nullForUndefinedEnumValue),
      medium: $enumDecodeNullable(_$MediumEnumMap, json['medium'],
          unknownValue: JsonKey.nullForUndefinedEnumValue),
    );

Map<String, dynamic> _$PurchasedItemToJson(PurchasedItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'purchaseDate': instance.purchaseDate.toIso8601String(),
      'category': _$PurchasedItemCategoryEnumMap[instance.category],
      'medium': _$MediumEnumMap[instance.medium],
    };

const _$PurchasedItemCategoryEnumMap = {
  PurchasedItemCategory.GROCERY: 'GROCERY',
  PurchasedItemCategory.ENTERTAINMENT: 'ENTERTAINMENT',
  PurchasedItemCategory.GAS: 'GAS',
  PurchasedItemCategory.SHOPPING: 'SHOPPING',
  PurchasedItemCategory.NEWSPAPER: 'NEWSPAPER',
  PurchasedItemCategory.TRANSPORTATION: 'TRANSPORTATION',
  PurchasedItemCategory.RENT: 'RENT',
};

const _$MediumEnumMap = {
  Medium.MANUAL: 'MANUAL',
};
