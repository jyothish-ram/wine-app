// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wine _$WineFromJson(Map<String, dynamic> json) => Wine(
  id: json['id'] as String,
  name: json['name'] as String,
  brand: json['brand'] as String?,
  vintage: json['vintage'] as String?,
  region: json['region'] as String?,
  country: json['country'] as String?,
  grapeVariety: json['grapeVariety'] as String?,
  type: json['type'] as String?,
  description: json['description'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
  imageUrl: json['imageUrl'] as String?,
  additionalInfo: json['additionalInfo'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$WineToJson(Wine instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'brand': instance.brand,
  'vintage': instance.vintage,
  'region': instance.region,
  'country': instance.country,
  'grapeVariety': instance.grapeVariety,
  'type': instance.type,
  'description': instance.description,
  'rating': instance.rating,
  'imageUrl': instance.imageUrl,
  'additionalInfo': instance.additionalInfo,
};
