import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'friend_request.g.dart';

@JsonSerializable(includeIfNull: false) @CopyWith(copyWithNull: true)
class FriendRequest {
  final int? id;
  @JsonKey(name: "created_at")
  final String? createdAt;

  @JsonKey(name: "sender_uid")
  final String? senderUid;
  @JsonKey(name: "receiver_uid")
  final String? receiverUid;
  @JsonKey(name: "accepted")
  final bool? accepted;

  FriendRequest({
    this.id,
    this.createdAt,
    this.senderUid,
    this.receiverUid,
    this.accepted
  });

  factory FriendRequest.fromJson(Map<String, dynamic> json) => _$FriendRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FriendRequestToJson(this);
}