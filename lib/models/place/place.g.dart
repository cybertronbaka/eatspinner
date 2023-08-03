// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PlaceCWProxy {
  Place id(int? id);

  Place createdAt(String? createdAt);

  Place creatorId(String? creatorId);

  Place name(String? name);

  Place description(String? description);

  Place rating(double? rating);

  Place lat(double? lat);

  Place lon(double? lon);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Place(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Place(...).copyWith(id: 12, name: "My name")
  /// ````
  Place call({
    int? id,
    String? createdAt,
    String? creatorId,
    String? name,
    String? description,
    double? rating,
    double? lat,
    double? lon,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPlace.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPlace.copyWith.fieldName(...)`
class _$PlaceCWProxyImpl implements _$PlaceCWProxy {
  const _$PlaceCWProxyImpl(this._value);

  final Place _value;

  @override
  Place id(int? id) => this(id: id);

  @override
  Place createdAt(String? createdAt) => this(createdAt: createdAt);

  @override
  Place creatorId(String? creatorId) => this(creatorId: creatorId);

  @override
  Place name(String? name) => this(name: name);

  @override
  Place description(String? description) => this(description: description);

  @override
  Place rating(double? rating) => this(rating: rating);

  @override
  Place lat(double? lat) => this(lat: lat);

  @override
  Place lon(double? lon) => this(lon: lon);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Place(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Place(...).copyWith(id: 12, name: "My name")
  /// ````
  Place call({
    Object? id = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? creatorId = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? rating = const $CopyWithPlaceholder(),
    Object? lat = const $CopyWithPlaceholder(),
    Object? lon = const $CopyWithPlaceholder(),
  }) {
    return Place(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String?,
      creatorId: creatorId == const $CopyWithPlaceholder()
          ? _value.creatorId
          // ignore: cast_nullable_to_non_nullable
          : creatorId as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      rating: rating == const $CopyWithPlaceholder()
          ? _value.rating
          // ignore: cast_nullable_to_non_nullable
          : rating as double?,
      lat: lat == const $CopyWithPlaceholder()
          ? _value.lat
          // ignore: cast_nullable_to_non_nullable
          : lat as double?,
      lon: lon == const $CopyWithPlaceholder()
          ? _value.lon
          // ignore: cast_nullable_to_non_nullable
          : lon as double?,
    );
  }
}

extension $PlaceCopyWith on Place {
  /// Returns a callable class that can be used as follows: `instanceOfPlace.copyWith(...)` or like so:`instanceOfPlace.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PlaceCWProxy get copyWith => _$PlaceCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `Place(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Place(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  Place copyWithNull({
    bool id = false,
    bool createdAt = false,
    bool creatorId = false,
    bool name = false,
    bool description = false,
    bool rating = false,
    bool lat = false,
    bool lon = false,
  }) {
    return Place(
      id: id == true ? null : this.id,
      createdAt: createdAt == true ? null : this.createdAt,
      creatorId: creatorId == true ? null : this.creatorId,
      name: name == true ? null : this.name,
      description: description == true ? null : this.description,
      rating: rating == true ? null : this.rating,
      lat: lat == true ? null : this.lat,
      lon: lon == true ? null : this.lon,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      id: json['id'] as int?,
      createdAt: json['created_at'] as String?,
      creatorId: json['creator_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PlaceToJson(Place instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('created_at', instance.createdAt);
  writeNotNull('creator_id', instance.creatorId);
  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('rating', instance.rating);
  writeNotNull('lat', instance.lat);
  writeNotNull('lon', instance.lon);
  return val;
}
