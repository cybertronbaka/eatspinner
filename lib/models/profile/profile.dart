import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'profile.g.dart';


@JsonSerializable(includeIfNull: false) @CopyWith(copyWithNull: true)
class Profile {
  final int? id;
  final int? age;
  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "bio")
  final String? bio;
  @JsonKey(name: "user_id")
  final String? userId;

  Profile({
    this.id,
    this.age,
    this.email,
    this.gender,
    this.name,
    this.bio,
    this.userId
  });

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}