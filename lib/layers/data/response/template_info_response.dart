import 'package:json_annotation/json_annotation.dart';

part 'template_info_response.g.dart';

@JsonSerializable()
class TemplateInfoResponse {
  TemplateInfoResponse();

  factory TemplateInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$TemplateInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TemplateInfoResponseToJson(this);
}
