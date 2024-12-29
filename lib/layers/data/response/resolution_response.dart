import 'package:json_annotation/json_annotation.dart';

part 'resolution_response.g.dart';

@JsonSerializable()
class ResolutionResponse {
  @JsonKey(name: '_id')
  String? id;

  String? cveId;

  List<ResolutionInfoResponse>? resolution;

  ResolutionResponse();

  factory ResolutionResponse.fromJson(Map<String, dynamic> json) =>
      _$ResolutionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResolutionResponseToJson(this);
}

@JsonSerializable()
class ResolutionInfoResponse {
  @JsonKey(name: '_id')
  String? id;

  String? createdBy;

  String? description;

  ResolutionInfoResponse();

  factory ResolutionInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$ResolutionInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResolutionInfoResponseToJson(this);
}
