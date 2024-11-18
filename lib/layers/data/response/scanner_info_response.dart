import 'package:json_annotation/json_annotation.dart';

part 'scanner_info_response.g.dart';

@JsonSerializable()
class ScannerInfoResponse {
  ScannerInfoResponse();

  factory ScannerInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$ScannerInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ScannerInfoResponseToJson(this);
}
