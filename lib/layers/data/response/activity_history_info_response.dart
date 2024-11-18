import 'package:json_annotation/json_annotation.dart';

part 'activity_history_info_response.g.dart';

@JsonSerializable()
class ActivityHistoryInfoResponse {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'object_id')
  String? objectId;

  String? action;

  String? account;

  DateTime? timestamp;

  String? description;

  ActivityHistoryInfoResponse();

  factory ActivityHistoryInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivityHistoryInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityHistoryInfoResponseToJson(this);
}
