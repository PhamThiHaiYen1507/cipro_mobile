// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'third_party_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThirdPartyInfoModel _$ThirdPartyInfoModelFromJson(Map json) =>
    ThirdPartyInfoModel(
      partyId: json['partyId'] as String,
      name: json['name'] as String?,
      username: json['username'] as String?,
      accessToken: json['accessToken'] as String?,
    );

Map<String, dynamic> _$ThirdPartyInfoModelToJson(
        ThirdPartyInfoModel instance) =>
    <String, dynamic>{
      'partyId': instance.partyId,
      'name': instance.name,
      'username': instance.username,
      'accessToken': instance.accessToken,
    };
