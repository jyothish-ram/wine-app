import 'package:json_annotation/json_annotation.dart';

part 'wine.g.dart';

@JsonSerializable()
class Wine {
  final String id;
  final String name;
  final String? brand;
  final String? vintage;
  final String? region;
  final String? country;
  final String? grapeVariety;
  final String? type; // red, white, rose, sparkling
  final String? description;
  final double? rating;
  final String? imageUrl;
  final Map<String, dynamic>? additionalInfo;

  Wine({
    required this.id,
    required this.name,
    this.brand,
    this.vintage,
    this.region,
    this.country,
    this.grapeVariety,
    this.type,
    this.description,
    this.rating,
    this.imageUrl,
    this.additionalInfo,
  });

  factory Wine.fromJson(Map<String, dynamic> json) => _$WineFromJson(json);
  Map<String, dynamic> toJson() => _$WineToJson(this);

  Wine copyWith({
    String? id,
    String? name,
    String? brand,
    String? vintage,
    String? region,
    String? country,
    String? grapeVariety,
    String? type,
    String? description,
    double? rating,
    String? imageUrl,
    Map<String, dynamic>? additionalInfo,
  }) {
    return Wine(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      vintage: vintage ?? this.vintage,
      region: region ?? this.region,
      country: country ?? this.country,
      grapeVariety: grapeVariety ?? this.grapeVariety,
      type: type ?? this.type,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }
}
