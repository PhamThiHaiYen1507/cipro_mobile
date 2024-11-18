import 'package:base_project/layers/domain/entities/third_party_info_model.dart';
import 'package:base_project/utils/enum/account_role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_info_model.g.dart';

@JsonSerializable()
class AccountInfoModel {
  final String accountId;

  final String username;

  final String email;

  final AccountRole role;

  final List<String> permission;

  final List<ThirdPartyInfoModel> thirdParty;

  AccountInfoModel({
    required this.accountId,
    required this.username,
    required this.email,
    required this.role,
    required this.permission,
    required this.thirdParty,
  });

  factory AccountInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$AccountInfoModelToJson(this);
}
