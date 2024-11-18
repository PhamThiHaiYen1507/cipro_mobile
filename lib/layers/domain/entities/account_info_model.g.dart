// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInfoModel _$AccountInfoModelFromJson(Map json) => AccountInfoModel(
      accountId: json['accountId'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      role: $enumDecode(_$AccountRoleEnumMap, json['role']),
      permission: (json['permission'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      thirdParty: (json['thirdParty'] as List<dynamic>)
          .map((e) =>
              ThirdPartyInfoModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$AccountInfoModelToJson(AccountInfoModel instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'username': instance.username,
      'email': instance.email,
      'role': _$AccountRoleEnumMap[instance.role]!,
      'permission': instance.permission,
      'thirdParty': instance.thirdParty.map((e) => e.toJson()).toList(),
    };

const _$AccountRoleEnumMap = {
  AccountRole.admin: 'admin',
  AccountRole.manager: 'manager',
  AccountRole.member: 'member',
};
