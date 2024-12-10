import 'package:base_project/layers/domain/entities/third_party_info_model.dart';
import 'package:base_project/utils/enum/account_role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_info_model.g.dart';

@JsonSerializable()
class AccountInfoModel {
  final String accountId;

  final String username;

  String email;

  AccountRole role;

  final List<String> permission;

  final List<ThirdPartyInfoModel> thirdParty;

  @JsonKey(includeToJson: false)
  List<PermissionGroup> permissionGroups = [
    PermissionGroup(groupName: "Ticket", actions: [
      PermissionAction(name: "create", isChecked: false),
      PermissionAction(name: "read", isChecked: false),
      PermissionAction(name: "update", isChecked: false),
      PermissionAction(name: "delete", isChecked: false),
    ]),
    PermissionGroup(groupName: "Task", actions: [
      PermissionAction(name: "create", isChecked: false),
      PermissionAction(name: "read", isChecked: false),
      PermissionAction(name: "update", isChecked: false),
      PermissionAction(name: "delete", isChecked: false),
    ]),
    PermissionGroup(groupName: "Atifacts", actions: [
      PermissionAction(name: "create", isChecked: false),
      PermissionAction(name: "read", isChecked: false),
      PermissionAction(name: "update", isChecked: false),
      PermissionAction(name: "delete", isChecked: false),
    ]),
    PermissionGroup(groupName: "Phase", actions: [
      PermissionAction(name: "create", isChecked: false),
      PermissionAction(name: "read", isChecked: false),
      PermissionAction(name: "update", isChecked: false),
      PermissionAction(name: "delete", isChecked: false),
    ]),
    PermissionGroup(groupName: "Project", actions: [
      PermissionAction(name: "create", isChecked: false),
      PermissionAction(name: "read", isChecked: false),
      PermissionAction(name: "update", isChecked: false),
      PermissionAction(name: "delete", isChecked: false),
    ]),
    PermissionGroup(groupName: "User", actions: [
      PermissionAction(name: "create", isChecked: false),
      PermissionAction(name: "read", isChecked: false),
      PermissionAction(name: "update", isChecked: false),
      PermissionAction(name: "delete", isChecked: false),
    ]),
  ];

  AccountInfoModel({
    required this.accountId,
    required this.username,
    required this.email,
    required this.role,
    required this.permission,
    required this.thirdParty,
  });

  static AccountInfoModel fromJson(
          Map<String, dynamic> json, List<PermissionGroup> permissionGroups) =>
      _$AccountInfoModelFromJson({
        ...json,
        'permissionGroups':
            updatePermissionsFromApi(json['permission'], permissionGroups),
      });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$AccountInfoModelToJson(AccountInfoModel(
        accountId: accountId,
        username: username,
        email: email,
        role: role,
        permission: getSelectedPermissions(permissionGroups),
        thirdParty: thirdParty));
    data.remove('accountId');
    data.remove('username');
    data.remove('thirdParty');
    return data;
  }

  List<String> getSelectedPermissions(List<PermissionGroup>? permissionGroups) {
    final permission = <String>[];
    if (permissionGroups != null) {
      for (var group in permissionGroups) {
        for (var action in group.actions) {
          if (action.isChecked) {
            permission.add("${group.groupName.toLowerCase()}:${action.name}");
          }
        }
      }
    }

    return permission;
  }

  static List<PermissionGroup> updatePermissionsFromApi(
      List<String> apiPermissions, List<PermissionGroup> permissionGroups) {
    for (var group in permissionGroups) {
      for (var action in group.actions) {
        final key = "${group.groupName.toLowerCase()}:${action.name}";
        action.isChecked = apiPermissions.contains(key);
      }
    }
    return permissionGroups;
  }
}

class PermissionAction {
  final String name;
  bool isChecked;

  PermissionAction({required this.name, this.isChecked = false});
}

class PermissionGroup {
  final String groupName;
  final List<PermissionAction> actions;

  PermissionGroup({required this.groupName, required this.actions});
}
