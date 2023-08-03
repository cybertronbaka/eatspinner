import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'place.g.dart';

@JsonSerializable(includeIfNull: false) @CopyWith(copyWithNull: true)
class Place {
      final int? id;
      @JsonKey(name: "created_at")
      final String? createdAt;

      @JsonKey(name: "creator_id")
      final String? creatorId;
      @JsonKey(name: "name")
      final String? name;
      @JsonKey(name: "description")
      final String? description;
      @JsonKey(name: "rating")
      final double? rating;
      @JsonKey(name: "lat")
      final double? lat;
      @JsonKey(name: "lon")
      final double? lon;

      Place({
            this.id,
            this.createdAt,
            this.creatorId,
            this.name,
            this.description,
            this.rating,
            this.lat,
            this.lon
      });

      factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

      Map<String, dynamic> toJson() => _$PlaceToJson(this);
}