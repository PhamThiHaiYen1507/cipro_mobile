// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_history_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityHistoryInfoModel _$ActivityHistoryInfoModelFromJson(Map json) =>
    ActivityHistoryInfoModel(
      id: json['id'] as String,
      objectId: json['objectId'] as String?,
      action: json['action'] as String?,
      account: json['account'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ActivityHistoryInfoModelToJson(
        ActivityHistoryInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'objectId': instance.objectId,
      'action': instance.action,
      'account': instance.account,
      'timestamp': instance.timestamp?.toIso8601String(),
      'description': instance.description,
    };
