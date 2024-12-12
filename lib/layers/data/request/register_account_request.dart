import 'package:json_annotation/json_annotation.dart';

part 'register_account_request.g.dart';

@JsonSerializable()
class RegisterAccountRequest {
  final String username;

  final String password;

  final String confirmPassword;

  final String email;

  RegisterAccountRequest(
      this.username, this.password, this.confirmPassword, this.email);

  factory RegisterAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterAccountRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterAccountRequestToJson(this);
}
