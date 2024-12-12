import 'package:base_project/layers/data/response/artifact_response.dart';
import 'package:base_project/layers/data/response/task_info_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phase_response.g.dart';

@JsonSerializable()
class PhaseResponse {
  String? name;

  String? description;

  int? order;

  @JsonKey(name: '_id')
  String? id;

  List<TaskInfoResponse>? tasks;

  List<ArtifactResponse>? artifacts;

  DateTime? createdAt;

  DateTime? updatedAt;

  PhaseResponse();

  factory PhaseResponse.fromJson(Map<String, dynamic> json) =>
      _$PhaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PhaseResponseToJson(this);
}
