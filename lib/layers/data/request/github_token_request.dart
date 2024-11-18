import 'package:json_annotation/json_annotation.dart';

part 'github_token_request.g.dart';

@JsonSerializable()
class GithubTokenRequest {
  @JsonKey(name: 'client_id')
  final String? clientId;

  @JsonKey(name: 'client_secret')
  final String? clientSecret;

  final String? code;

  final String? state;

  @JsonKey(name: 'redirect_uri')
  final String? redirectUri;

  GithubTokenRequest(
      {this.clientId,
      this.clientSecret,
      this.code,
      this.state,
      this.redirectUri});

  factory GithubTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$GithubTokenRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GithubTokenRequestToJson(this);
}
