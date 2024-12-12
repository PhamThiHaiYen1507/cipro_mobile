import 'package:base_project/layers/data/response/phase_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phase_template_response.g.dart';

@JsonSerializable()
class PhaseTemplateResponse {
  @JsonKey(name: '_id')
  String? id;

  String? name;

  String? description;

  List<PhaseResponse>? phases;

  bool? isPrivate;

  String? createdBy;

  PhaseTemplateResponse();

  factory PhaseTemplateResponse.fromJson(Map<String, dynamic> json) =>
      _$PhaseTemplateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PhaseTemplateResponseToJson(this);
}
