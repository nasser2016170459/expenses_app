import 'package:inovola/core/models/medium.dart';
import 'package:inovola/core/models/purchased_item_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'purchased_item.g.dart';

@JsonSerializable()
class PurchasedItem {
  final String id;
  final double price;
  final DateTime purchaseDate;
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final PurchasedItemCategory? category;
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final Medium? medium;

  PurchasedItem({
    required this.id,
    required this.price,
    required this.purchaseDate,
    required this.category,
    required this.medium,
  });

  factory PurchasedItem.fromJson(Map<String, dynamic> json) => _$PurchasedItemFromJson(json);

  Map<String, dynamic> toJson() => _$PurchasedItemToJson(this);
}
