import 'package:json_annotation/json_annotation.dart';

part 'workflow_info_model.g.dart';

@JsonSerializable()
class WorkflowInfoModel {
  final String name;

  final String path;

  final String content;

  WorkflowInfoModel(
      {required this.name, required this.path, required this.content});

  factory WorkflowInfoModel.fromJson(Map<String, dynamic> json) =>
      _$WorkflowInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$WorkflowInfoModelToJson(this);
}
