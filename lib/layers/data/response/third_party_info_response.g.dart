// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'third_party_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThirdPartyInfoResponse _$ThirdPartyInfoResponseFromJson(Map json) =>
    ThirdPartyInfoResponse()
      ..name = json['name'] as String?
      ..username = json['username'] as String?
      ..accessToken = json['accessToken'] as String?
      ..sId = json['_id'] as String?;

Map<String, dynamic> _$ThirdPartyInfoResponseToJson(
        ThirdPartyInfoResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'accessToken': instance.accessToken,
      '_id': instance.sId,
    };
