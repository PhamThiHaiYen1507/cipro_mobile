import 'package:json_annotation/json_annotation.dart';

part 'template_info_model.g.dart';

@JsonSerializable()
class TemplateInfoModel {
  TemplateInfoModel();

  factory TemplateInfoModel.fromJson(Map<String, dynamic> json) =>
      _$TemplateInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$TemplateInfoModelToJson(this);
}
