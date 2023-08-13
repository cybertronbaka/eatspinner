// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProfileCWProxy {
  Profile id(int? id);

  Profile age(int? age);

  Profile email(String? email);

  Profile gender(String? gender);

  Profile name(String? name);

  Profile bio(String? bio);

  Profile userId(String? userId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Profile(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Profile(...).copyWith(id: 12, name: "My name")
  /// ````
  Profile call({
    int? id,
    int? age,
    String? email,
    String? gender,
    String? name,
    String? bio,
    String? userId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProfile.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProfile.copyWith.fieldName(...)`
class _$ProfileCWProxyImpl implements _$ProfileCWProxy {
  const _$ProfileCWProxyImpl(this._value);

  final Profile _value;

  @override
  Profile id(int? id) => this(id: id);

  @override
  Profile age(int? age) => this(age: age);

  @override
  Profile email(String? email) => this(email: email);

  @override
  Profile gender(String? gender) => this(gender: gender);

  @override
  Profile name(String? name) => this(name: name);

  @override
  Profile bio(String? bio) => this(bio: bio);

  @override
  Profile userId(String? userId) => this(userId: userId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Profile(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Profile(...).copyWith(id: 12, name: "My name")
  /// ````
  Profile call({
    Object? id = const $CopyWithPlaceholder(),
    Object? age = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? bio = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
  }) {
    return Profile(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      age: age == const $CopyWithPlaceholder()
          ? _value.age
          // ignore: cast_nullable_to_non_nullable
          : age as int?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      gender: gender == const $CopyWithPlaceholder()
          ? _value.gender
          // ignore: cast_nullable_to_non_nullable
          : gender as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      bio: bio == const $CopyWithPlaceholder()
          ? _value.bio
          // ignore: cast_nullable_to_non_nullable
          : bio as String?,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
    );
  }
}

extension $ProfileCopyWith on Profile {
  /// Returns a callable class that can be used as follows: `instanceOfProfile.copyWith(...)` or like so:`instanceOfProfile.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProfileCWProxy get copyWith => _$ProfileCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `Profile(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Profile(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  Profile copyWithNull({
    bool id = false,
    bool age = false,
    bool email = false,
    bool gender = false,
    bool name = false,
    bool bio = false,
    bool userId = false,
  }) {
    return Profile(
      id: id == true ? null : this.id,
      age: age == true ? null : this.age,
      email: email == true ? null : this.email,
      gender: gender == true ? null : this.gender,
      name: name == true ? null : this.name,
      bio: bio == true ? null : this.bio,
      userId: userId == true ? null : this.userId,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      id: json['id'] as int?,
      age: json['age'] as int?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      name: json['name'] as String?,
      bio: json['bio'] as String?,
      userId: json['user_id'] as String?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('age', instance.age);
  writeNotNull('email', instance.email);
  writeNotNull('gender', instance.gender);
  writeNotNull('name', instance.name);
  writeNotNull('bio', instance.bio);
  writeNotNull('user_id', instance.userId);
  return val;
}
