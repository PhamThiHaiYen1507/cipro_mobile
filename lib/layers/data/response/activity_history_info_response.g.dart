// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_history_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityHistoryInfoResponse _$ActivityHistoryInfoResponseFromJson(Map json) =>
    ActivityHistoryInfoResponse()
      ..id = json['_id'] as String?
      ..objectId = json['object_id'] as String?
      ..action = json['action'] as String?
      ..account = json['account'] as String?
      ..timestamp = json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String)
      ..description = json['description'] as String?;

Map<String, dynamic> _$ActivityHistoryInfoResponseToJson(
        ActivityHistoryInfoResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'object_id': instance.objectId,
      'action': instance.action,
      'account': instance.account,
      'timestamp': instance.timestamp?.toIso8601String(),
      'description': instance.description,
    };
