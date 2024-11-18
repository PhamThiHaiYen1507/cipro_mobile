// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_account_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterAccountRequest _$RegisterAccountRequestFromJson(Map json) =>
    RegisterAccountRequest(
      json['username'] as String,
      json['password'] as String,
      json['confirmPassword'] as String,
      json['email'] as String,
    );

Map<String, dynamic> _$RegisterAccountRequestToJson(
        RegisterAccountRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'email': instance.email,
    };
