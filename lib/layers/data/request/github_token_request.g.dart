// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubTokenRequest _$GithubTokenRequestFromJson(Map json) => GithubTokenRequest(
      clientId: json['client_id'] as String?,
      clientSecret: json['client_secret'] as String?,
      code: json['code'] as String?,
      state: json['state'] as String?,
      redirectUri: json['redirect_uri'] as String?,
    );

Map<String, dynamic> _$GithubTokenRequestToJson(GithubTokenRequest instance) =>
    <String, dynamic>{
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
      'code': instance.code,
      'state': instance.state,
      'redirect_uri': instance.redirectUri,
    };
