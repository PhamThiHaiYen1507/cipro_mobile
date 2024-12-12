import 'package:json_annotation/json_annotation.dart';

part 'activity_history_info_model.g.dart';

@JsonSerializable()
class ActivityHistoryInfoModel {
  final String id;

  final String? objectId;

  final String? action;

  final String? account;

  final DateTime? timestamp;

  final String? description;

  ActivityHistoryInfoModel({
    required this.id,
    this.objectId,
    this.action,
    this.account,
    this.timestamp,
    this.description,
  });

  factory ActivityHistoryInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityHistoryInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityHistoryInfoModelToJson(this);
}
