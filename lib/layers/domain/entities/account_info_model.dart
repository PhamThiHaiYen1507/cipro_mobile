import 'package:base_project/layers/domain/entities/third_party_info_model.dart';
import 'package:base_project/utils/enum/account_role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_info_model.g.dart';

const List<String> permissionGroups = [
  "ticket",
  "task",
  "phase",
  "project",
  "artifact",
  "user",
];
const List<String> allPermissions = [
  "ticket:create",
  "ticket:read",
  "ticket:update",
  "ticket:delete",
  "task:create",
  "task:read",
  "task:update",
  "task:delete",
  "phase:create",
  "phase:read",
  "phase:update",
  "phase:delete",
  "project:create",
  "project:read",
  "project:update",
  "project:delete",
  "artifact:create",
  "artifact:read",
  "artifact:update",
  "artifact:delete",
  "user:create",
  "user:read",
  "user:update",
  "user:delete",
];

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

@JsonSerializable()
class AccountInfoModel {
  final String accountId;

  final String username;

  String email;

  AccountRole role;

  final List<String> permission;

  final List<ThirdPartyInfoModel> thirdParty;

  final List<String> notifications;

  AccountInfoModel({
    required this.accountId,
    required this.username,
    required this.email,
    required this.role,
    required this.permission,
    required this.thirdParty,
    required this.notifications,
  });

  factory AccountInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$AccountInfoModelToJson(this);
    data.remove('accountId');
    data.remove('username');
    data.remove('thirdParty');
    return data;
  }
}
