// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FriendRequestCWProxy {
  FriendRequest id(int? id);

  FriendRequest createdAt(String? createdAt);

  FriendRequest senderUid(String? senderUid);

  FriendRequest receiverUid(String? receiverUid);

  FriendRequest accepted(bool? accepted);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FriendRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FriendRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  FriendRequest call({
    int? id,
    String? createdAt,
    String? senderUid,
    String? receiverUid,
    bool? accepted,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFriendRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFriendRequest.copyWith.fieldName(...)`
class _$FriendRequestCWProxyImpl implements _$FriendRequestCWProxy {
  const _$FriendRequestCWProxyImpl(this._value);

  final FriendRequest _value;

  @override
  FriendRequest id(int? id) => this(id: id);

  @override
  FriendRequest createdAt(String? createdAt) => this(createdAt: createdAt);

  @override
  FriendRequest senderUid(String? senderUid) => this(senderUid: senderUid);

  @override
  FriendRequest receiverUid(String? receiverUid) =>
      this(receiverUid: receiverUid);

  @override
  FriendRequest accepted(bool? accepted) => this(accepted: accepted);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FriendRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FriendRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  FriendRequest call({
    Object? id = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? senderUid = const $CopyWithPlaceholder(),
    Object? receiverUid = const $CopyWithPlaceholder(),
    Object? accepted = const $CopyWithPlaceholder(),
  }) {
    return FriendRequest(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String?,
      senderUid: senderUid == const $CopyWithPlaceholder()
          ? _value.senderUid
          // ignore: cast_nullable_to_non_nullable
          : senderUid as String?,
      receiverUid: receiverUid == const $CopyWithPlaceholder()
          ? _value.receiverUid
          // ignore: cast_nullable_to_non_nullable
          : receiverUid as String?,
      accepted: accepted == const $CopyWithPlaceholder()
          ? _value.accepted
          // ignore: cast_nullable_to_non_nullable
          : accepted as bool?,
    );
  }
}

extension $FriendRequestCopyWith on FriendRequest {
  /// Returns a callable class that can be used as follows: `instanceOfFriendRequest.copyWith(...)` or like so:`instanceOfFriendRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FriendRequestCWProxy get copyWith => _$FriendRequestCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `FriendRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FriendRequest(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  FriendRequest copyWithNull({
    bool id = false,
    bool createdAt = false,
    bool senderUid = false,
    bool receiverUid = false,
    bool accepted = false,
  }) {
    return FriendRequest(
      id: id == true ? null : this.id,
      createdAt: createdAt == true ? null : this.createdAt,
      senderUid: senderUid == true ? null : this.senderUid,
      receiverUid: receiverUid == true ? null : this.receiverUid,
      accepted: accepted == true ? null : this.accepted,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendRequest _$FriendRequestFromJson(Map<String, dynamic> json) =>
    FriendRequest(
      id: json['id'] as int?,
      createdAt: json['created_at'] as String?,
      senderUid: json['sender_uid'] as String?,
      receiverUid: json['receiver_uid'] as String?,
      accepted: json['accepted'] as bool?,
    );

Map<String, dynamic> _$FriendRequestToJson(FriendRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('created_at', instance.createdAt);
  writeNotNull('sender_uid', instance.senderUid);
  writeNotNull('receiver_uid', instance.receiverUid);
  writeNotNull('accepted', instance.accepted);
  return val;
}
