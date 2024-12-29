import 'package:base_project/layers/data/response/third_party_info_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_info_response.g.dart';

@JsonSerializable()
class AccountInfoResponse {
  @JsonKey(name: '_id')
  String? sId;

  String? username;

  String? email;

  String? role;

  List<String>? permission;

  List<ThirdPartyInfoResponse>? thirdParty;

  List<String>? notifications;

  AccountInfoResponse();

  factory AccountInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AccountInfoResponseToJson(this);
}
