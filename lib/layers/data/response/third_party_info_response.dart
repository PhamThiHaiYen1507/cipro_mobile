import 'package:json_annotation/json_annotation.dart';

part 'third_party_info_response.g.dart';

@JsonSerializable()
class ThirdPartyInfoResponse {
  String? name;

  String? username;

  String? accessToken;

  @JsonKey(name: '_id')
  String? sId;

  ThirdPartyInfoResponse();

  factory ThirdPartyInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$ThirdPartyInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ThirdPartyInfoResponseToJson(this);
}
