// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInfoResponse _$AccountInfoResponseFromJson(Map json) =>
    AccountInfoResponse()
      ..sId = json['_id'] as String?
      ..username = json['username'] as String?
      ..email = json['email'] as String?
      ..role = json['role'] as String?
      ..permission = (json['permission'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..thirdParty = (json['thirdParty'] as List<dynamic>?)
          ?.map((e) => ThirdPartyInfoResponse.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .toList();

Map<String, dynamic> _$AccountInfoResponseToJson(
        AccountInfoResponse instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'username': instance.username,
      'email': instance.email,
      'role': instance.role,
      'permission': instance.permission,
      'thirdParty': instance.thirdParty?.map((e) => e.toJson()).toList(),
    };
