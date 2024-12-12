import 'package:json_annotation/json_annotation.dart';

part 'third_party_info_model.g.dart';

@JsonSerializable()
class ThirdPartyInfoModel {
  final String partyId;

  final String? name;

  final String? username;

  final String? accessToken;

  ThirdPartyInfoModel(
      {required this.partyId, this.name, this.username, this.accessToken});

  factory ThirdPartyInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ThirdPartyInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$ThirdPartyInfoModelToJson(this);
}
